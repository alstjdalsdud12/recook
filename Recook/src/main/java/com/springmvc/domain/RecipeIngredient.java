package com.springmvc.domain;

public class RecipeIngredient {
    private int ri_no;
    private int r_no;
    private String ri_name;
    private double ri_quantity;
    private String ri_unit;
    private String ri_note;

    public int getRi_no() { return ri_no; }
    public void setRi_no(int ri_no) { this.ri_no = ri_no; }
    public int getR_no() { return r_no; }
    public void setR_no(int r_no) { this.r_no = r_no; }
    public String getRi_name() { return ri_name; }
    public void setRi_name(String ri_name) { this.ri_name = ri_name; }
    public double getRi_quantity() { return ri_quantity; }
    public void setRi_quantity(double ri_quantity) { this.ri_quantity = ri_quantity; }
    public String getRi_unit() { return ri_unit; }
    public void setRi_unit(String ri_unit) { this.ri_unit = ri_unit; }
    public String getRi_note() { return ri_note; }
    public void setRi_note(String ri_note) { this.ri_note = ri_note; }
}