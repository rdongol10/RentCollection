package com.rdongol.rentcollection.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.Image;
import com.rdongol.rentcollection.repository.ImageRepository;

@Service
public class ImageService {

	@Autowired
	private ImageRepository imageRepository;

	public List<Image> findAll() {
		return (List<Image>) imageRepository.findAll();
	}

	public Image findById(Long id) {

		Optional<Image> image = imageRepository.findById(id);

		if (!image.isPresent()) {
			return null;
		}

		return image.get();
	}

	public Image save(Image image) {
		return imageRepository.save(image);
	}

	public void deleteById(Long id) {
		imageRepository.deleteById(id);
	}

}
