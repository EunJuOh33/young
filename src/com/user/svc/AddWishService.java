package com.user.svc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.shop.bean.*;
import com.user.bean.*;

public class AddWishService {
	
	public void addCart(HttpServletRequest request, Prd bean) {
		HttpSession session = request.getSession();
		ArrayList<wishbean> wishList = (ArrayList<wishbean>)session.getAttribute("wishList");
		
		if(wishList == null) {
			wishList = new ArrayList<wishbean>();
			session.setAttribute("wishList", wishList);
		}
		
		boolean isNewWish = true;
		
		for(int i=0; i<wishList.size(); i++) {
			if(bean.getName().equals(wishList.get(i).getWish_name())) {
				isNewWish = false;
				break;
			}
		}
		if(isNewWish) {
			wishbean wish = new wishbean();
			wish.setWish_image(bean.getImage());
			wish.setWish_name(bean.getName());
			wish.setWish_price(bean.getPrice());
			wish.setWish_qty(1);
			wish.setWish_content(bean.getContent());
			wishList.add(wish);
		}
		
		
	}
}
