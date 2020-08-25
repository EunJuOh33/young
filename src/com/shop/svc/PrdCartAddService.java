package com.shop.svc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.shop.dao.PrdDAO;

import java.sql.Connection;
import java.util.ArrayList;

import com.shop.bean.*;

public class PrdCartAddService {

	
//	public Prd getCartPrd(int id) {
//		PrdDAO prdDAO = PrdDAO.getInstance();
//		Prd prd = prdDAO.selectPrd(id);
//		close();
//		return prd;
//	}


	public void addCart(HttpServletRequest request, Prd cartPrd) {
		HttpSession session = request.getSession();
		ArrayList<Cart> cartList = (ArrayList<Cart>)session.getAttribute("cartList");
		
		if(cartList == null) {
			cartList = new ArrayList<Cart>();
			session.setAttribute("cartList", cartList);
		}
		
		boolean isNewCart = true;
		
		for(int i=0; i<cartList.size(); i++) {
			if(cartPrd.getName().equals(cartList.get(i).getName())) {
				isNewCart = false;
				cartList.get(i).setQty(cartList.get(i).getQty()+1);
				break;
			}
		}
		if(isNewCart) {
			Cart cart = new Cart();
			cart.setImage(cartPrd.getImage());
			cart.setName(cartPrd.getName());
			cart.setPrice(cartPrd.getPrice());
			cart.setQty(1);
			cartList.add(cart);
		}
		
		
	}

}
