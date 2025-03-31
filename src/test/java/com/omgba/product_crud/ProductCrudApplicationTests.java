package com.omgba.product_crud;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.Date;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import com.omgba.product_crud.model.Product;
import com.omgba.product_crud.repository.ProductRepository;

@SpringBootTest
@ActiveProfiles("test")
class ProductCrudApplicationTests {

	@Autowired
	private ProductRepository productRepository;

	@Test
	void testCreateProduct() { // Removed 'public'
		Product product = new Product("Iphone 12", 800.0, new Date());
		Product savedProduct = productRepository.save(product);

		// Added assertion to verify the product was saved
		assertNotNull(savedProduct.getIdProduct());
		assertEquals("Iphone 12", savedProduct.getNameProduct());
	}

	@Test
	void testFindProduct() { // Removed 'public'
		Product product = new Product("MacBook Pro", 2000.0, new Date());
		productRepository.save(product);

		Product foundProduct = productRepository.findById(product.getIdProduct()).orElse(null);
		assertNotNull(foundProduct);
		assertEquals("MacBook Pro", foundProduct.getNameProduct());
	}

}