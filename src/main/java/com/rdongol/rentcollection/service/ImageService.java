package com.rdongol.rentcollection.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.rdongol.rentcollection.model.Image;
import com.rdongol.rentcollection.repository.ImageRepository;

@Service
public class ImageService {

	public final String IMAGE_FOLDER = "D:\\work\\images\\";
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

	public Image save(Long objectId, String objectType, MultipartFile file) {

		Image image = new Image();
		try {
			byte[] bytes = file.getBytes();

			String imageName = getImageName(file, objectId, objectType);
			Path path = Paths.get(IMAGE_FOLDER, imageName);
			Files.write(path, bytes);

			image.setObjectId(objectId);
			image.setObjectType(objectType);
			image.setImageLocation(IMAGE_FOLDER);
			image.setImageName(imageName);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return imageRepository.save(image);
	}

	public List<Image> save(Long objectId, String objectType, MultipartFile[] files) {

		List<Image> images = new LinkedList<Image>();
		for (MultipartFile file : files) {
			try {
				byte[] bytes = file.getBytes();

				String imageName = getImageName(file, objectId, objectType);
				Path path = Paths.get(IMAGE_FOLDER, imageName);
				Files.write(path, bytes);

				Image image = new Image();
				image.setObjectId(objectId);
				image.setObjectType(objectType);
				image.setImageLocation(IMAGE_FOLDER);
				image.setImageName(imageName);

				images.add(imageRepository.save(image));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return images;
	}

	private String getImageName(MultipartFile file, Long objectId, String objectType) {

		String filename = objectType + "_" + objectId + "_" + new Timestamp(System.currentTimeMillis()).getTime();
		String extention = "";
		if (file.getContentType().equalsIgnoreCase("image/jpeg")) {
			extention = ".jpg";
		} else if (file.getContentType().equalsIgnoreCase("image/png")) {
			extention = ".png";
		}
		
		return filename + extention;
	}

}
