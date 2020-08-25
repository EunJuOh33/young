package com.shop.svc;

import java.util.ArrayList;
import com.shop.dao.PrdDAO;
import com.shop.bean.Prd;

public class PrdListService {

	public ArrayList<Prd> getPrdList() {
		PrdDAO prdDAO = PrdDAO.getInstance();
		ArrayList<Prd> prdList = prdDAO.selectPrdList();
		return prdList;
	}

}
