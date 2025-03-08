package com.example.picao.establishment.service.impl;

import com.example.picao.city.entity.City;
import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.establishment.dto.CreateEstablishmentRequestDTO;
import com.example.picao.establishment.dto.EstablishmentResponseDTO;
import com.example.picao.establishment.entity.Establishment;
import com.example.picao.establishment.mapper.EstablishmentMapper;
import com.example.picao.establishment.repository.EstablishmentRepository;
import com.example.picao.establishment.service.EstablishmentService;
import com.example.picao.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@RequiredArgsConstructor()
@Service
public class EstablishmentServiceImpl implements EstablishmentService {

    private static final EstablishmentMapper MAPPER = Mappers.getMapper(EstablishmentMapper.class);
    private final EstablishmentRepository establishmentRepository;
    private final UserRepository userRepository;
    private final CityRepository cityRepository;

    @Override
    @Transactional
    public EstablishmentResponseDTO create(CreateEstablishmentRequestDTO requestDTO) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            City city = cityRepository.findById(requestDTO.cityId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            establishmentRepository.findByName(requestDTO.name()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_ESTABLISHMENT_NAME, HttpStatus.BAD_REQUEST);
                    });

            establishmentRepository.findByMobileNumber(requestDTO.mobileNumber()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_PHONE_NUMBER, HttpStatus.BAD_REQUEST);
                    });


            Establishment establishment = MAPPER.toEstablishment(requestDTO);

            establishment.setCity(city);
            establishment.setDepartment(city.getDepartment());


            establishment.setOwnerUser(userRepository.findByEmail(authentication.getPrincipal().toString())
                    .orElseThrow(
                            () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND)));


            return MAPPER.toEstablishmentResponseDTO(establishmentRepository.save(establishment));


        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<EstablishmentResponseDTO> getByOwnerUserId(Integer userId) {
        try {
            return establishmentRepository.findByOwnerUserId(userId)
                    .stream()
                    .map(
                            MAPPER::toEstablishmentResponseDTO).toList();

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }
}

