package com.son.util;

import com.son.data.model.OrderItem;

import java.util.List;

public class Helper {
    public static double total(List<OrderItem> orderItemList){
        double total = 0;
        for (int i = 0; i < orderItemList.size(); i++) {
            OrderItem ord = orderItemList.get(0);
            total += ord.getPrice() * ord.getQuantity();
        }

        return total;
    }
}
