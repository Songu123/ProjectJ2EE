package com.son.utils;

import com.son.data.model.OrderItem;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.List;

public class Helper {

    private static final DecimalFormat CURRENCY_FORMAT = new DecimalFormat("#,##0.00");
    private static final DecimalFormat DECIMAL_FORMAT = new DecimalFormat("0.00");

    /**
     * Round double to 2 decimal places
     * @param value Value to round
     * @return Rounded value with 2 decimal places
     */
    public static double roundToTwoDecimals(double value) {
        return BigDecimal.valueOf(value)
                .setScale(2, RoundingMode.HALF_UP)
                .doubleValue();
    }

    /**
     * Calculate total amount from list of OrderItems
     * @param orderItemList List of OrderItem objects
     * @return Total amount as double with 2 decimal places
     */
    public static double total(List<OrderItem> orderItemList) {
        if (orderItemList == null || orderItemList.isEmpty()) {
            return 0.00;
        }

        double total = 0;
        for (OrderItem orderItem : orderItemList) {
            if (orderItem != null) {
                total += orderItem.getPrice() * orderItem.getQuantity();
            }
        }

        return roundToTwoDecimals(total);
    }

    /**
     * Calculate total amount with tax
     * @param orderItemList List of OrderItem objects
     * @param taxRate Tax rate (e.g., 0.1 for 10%)
     * @return Total amount including tax with 2 decimal places
     */
    public static double totalWithTax(List<OrderItem> orderItemList, double taxRate) {
        double subtotal = total(orderItemList);
        double totalWithTax = subtotal + (subtotal * taxRate);
        return roundToTwoDecimals(totalWithTax);
    }

    /**
     * Calculate total quantity of items
     * @param orderItemList List of OrderItem objects
     * @return Total quantity as integer
     */
    public static int totalQuantity(List<OrderItem> orderItemList) {
        if (orderItemList == null || orderItemList.isEmpty()) {
            return 0;
        }

        int totalQty = 0;
        for (OrderItem orderItem : orderItemList) {
            if (orderItem != null) {
                totalQty += orderItem.getQuantity();
            }
        }

        return totalQty;
    }

    /**
     * Format currency amount for display with 2 decimal places
     * @param amount Amount to format
     * @return Formatted currency string
     */
    public static String formatCurrency(double amount) {
        return "$" + CURRENCY_FORMAT.format(roundToTwoDecimals(amount));
    }

    /**
     * Format decimal number to 2 decimal places
     * @param amount Amount to format
     * @return Formatted decimal string
     */
    public static String formatDecimal(double amount) {
        return DECIMAL_FORMAT.format(roundToTwoDecimals(amount));
    }

    /**
     * Calculate discount amount
     * @param subtotal Subtotal amount
     * @param discountPercent Discount percentage (e.g., 10 for 10%)
     * @return Discount amount with 2 decimal places
     */
    public static double calculateDiscount(double subtotal, double discountPercent) {
        if (discountPercent < 0 || discountPercent > 100) {
            return 0.00;
        }
        double discount = subtotal * (discountPercent / 100);
        return roundToTwoDecimals(discount);
    }

    /**
     * Calculate tax amount
     * @param subtotal Subtotal amount
     * @param taxRate Tax rate (e.g., 0.1 for 10%)
     * @return Tax amount with 2 decimal places
     */
    public static double calculateTax(double subtotal, double taxRate) {
        double tax = subtotal * taxRate;
        return roundToTwoDecimals(tax);
    }

    /**
     * Calculate shipping cost based on total amount
     * @param subtotal Subtotal amount
     * @param freeShippingThreshold Minimum amount for free shipping
     * @param standardShippingCost Standard shipping cost
     * @return Shipping cost with 2 decimal places
     */
    public static double calculateShipping(double subtotal, double freeShippingThreshold, double standardShippingCost) {
        double shipping = subtotal >= freeShippingThreshold ? 0.0 : standardShippingCost;
        return roundToTwoDecimals(shipping);
    }

    /**
     * Calculate final total (subtotal + tax + shipping - discount)
     * @param subtotal Subtotal amount
     * @param tax Tax amount
     * @param shipping Shipping cost
     * @param discount Discount amount
     * @return Final total with 2 decimal places
     */
    public static double calculateFinalTotal(double subtotal, double tax, double shipping, double discount) {
        double finalTotal = subtotal + tax + shipping - discount;
        return roundToTwoDecimals(finalTotal);
    }

    /**
     * Validate if order items list is valid for processing
     * @param orderItemList List of OrderItem objects
     * @return true if valid, false otherwise
     */
    public static boolean isValidOrderItems(List<OrderItem> orderItemList) {
        if (orderItemList == null || orderItemList.isEmpty()) {
            return false;
        }

        for (OrderItem item : orderItemList) {
            if (item == null || item.getQuantity() <= 0 || item.getPrice() < 0) {
                return false;
            }
        }

        return true;
    }
}