package com.rdongol.rentcollection.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import javax.imageio.ImageIO;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public Image save(Long objectId, String objectType, String imageBase64) {
		Image image = new Image();
		try {
			byte[] imageByte = Base64.decodeBase64(imageBase64.split(",")[1]);
			ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
			BufferedImage bufferedImage = ImageIO.read(bis);
			String filename = getImageName(objectId, objectType);
			File outputfile = new File(IMAGE_FOLDER, filename);
			ImageIO.write(bufferedImage, "png", outputfile);
			bis.close();
			image.setImageName(filename);
			image.setImageLocation(IMAGE_FOLDER);
			image.setObjectId(objectId);
			image.setObjectType(objectType);

		} catch (IOException e) {
			e.printStackTrace();
		}
		return imageRepository.save(image);
	}

	public List<Image> save(Long objectId, String objectType, List<String> imageBase64s) {

		List<Image> images = new LinkedList<Image>();
		for (String imageBase64 : imageBase64s) {
			images.add(save(objectId, objectType, imageBase64));
		}
		return images;
	}

	public void deleteImages(Long objectId, String objectType) {
		List<Image> images = getImageByObjectTypeAndObjectId(objectType, objectId);
		for (Image image : images) {
			File imageFile = new File(image.getImageLocation(), image.getImageName());
			if (deleteFile(imageFile)) {
				deleteById(image.getId());
			}
		}
	}

	public Image update(Long objectId, String objectType, String imageBase64) {
		List<Image> images = getImageByObjectTypeAndObjectId(objectType, objectId);

		if (images == null || images.isEmpty()) {
			return save(objectId, objectType, imageBase64);
		}

		Image image = images.get(0);
		try {
			File imageFile = new File(image.getImageLocation(), image.getImageName());
			if (deleteFile(imageFile)) {
				byte[] imageByte = Base64.decodeBase64(imageBase64.split(",")[1]);
				ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
				BufferedImage bufferedImage = ImageIO.read(bis);
				String filename = getImageName(objectId, objectType);
				File outputfile = new File(IMAGE_FOLDER, filename);
				ImageIO.write(bufferedImage, "png", outputfile);
				bis.close();
				image.setImageName(filename);
				image.setImageLocation(IMAGE_FOLDER);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return save(image);
	}

	public boolean deleteFile(File imageFile) {
		return imageFile.delete();
	}

	private String getImageName(Long objectId, String objectType) {

		String filename = objectType + "_" + objectId + "_" + new Timestamp(System.currentTimeMillis()).getTime()
				+ ".png";

		return filename;
	}

	public List<Image> getImageByObjectTypeAndObjectId(String objectType, long objectId) {
		return imageRepository.getImageByObjectTypeAndObjectId(objectType, objectId);
	}

	public String getImageBase64(long objectId, String objectType) {
		List<Image> images = getImageByObjectTypeAndObjectId(objectType, objectId);
		if (images == null || images.isEmpty()) {
			return null;
		}

		return getImageBase64(images.get(0));
	}

	public List<String> getImageBase64s(long objectId, String objectType) {

		List<Image> images = getImageByObjectTypeAndObjectId(objectType, objectId);

		return getImageBase64s(images);
	}

	public List<String> getImageBase64s(List<Image> images) {
		List<String> imageBase64s = new LinkedList<String>();
		for (Image image : images) {

			String imageBase64 = getImageBase64(image);
			if (imageBase64 != null) {
				imageBase64s.add(imageBase64);
			}
		}

		return imageBase64s;
	}

	public String getImageBase64(Image image) {

		if (image == null) {
			return null;
		}

		File file = new File(image.getImageLocation(), image.getImageName());

		FileInputStream fileInputStreamReader;
		String base64 = null;
		try {
			fileInputStreamReader = new FileInputStream(file);
			byte[] bytes = new byte[(int) file.length()];
			fileInputStreamReader.read(bytes);
			base64 = new String(Base64.encodeBase64(bytes), "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return base64;
	}

}
