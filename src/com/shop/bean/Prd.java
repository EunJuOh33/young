package com.shop.bean;

public class Prd {
	private int id;
	private String name;
	private int price;
	private String image;
	private String content;
	
	public Prd(int id, String name, int price, String image, String content) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.content = content;
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
