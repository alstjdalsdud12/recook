package com.springmvc.domain;

public class Member {
    private int m_no;
    private String m_nickname;
    private String m_id;
    private String m_pw;
    private String m_birth;
    private String m_gender;
    private String m_phone;
    private String m_email;
    private String m_datetime;
    private String m_role;
    private String m_status;
    private String m_profile_image;

    public Member() {}

    public Member(int m_no, String m_nickname, String m_id, String m_pw,
                  String m_birth, String m_gender, String m_phone, String m_email, String m_datetime) {
        this.m_no = m_no;
        this.m_nickname = m_nickname;
        this.m_id = m_id;
        this.m_pw = m_pw;
        this.m_birth = m_birth;
        this.m_gender = m_gender;
        this.m_phone = m_phone;
        this.m_email = m_email;
        this.m_datetime = m_datetime;
        this.m_role = m_role;
    }

    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }
    public String getM_nickname() { return m_nickname; }
    public void setM_nickname(String m_nickname) { this.m_nickname = m_nickname; }
    public String getM_id() { return m_id; }
    public void setM_id(String m_id) { this.m_id = m_id; }
    public String getM_pw() { return m_pw; }
    public void setM_pw(String m_pw) { this.m_pw = m_pw; }
    public String getM_birth() { return m_birth; }
    public void setM_birth(String m_birth) { this.m_birth = m_birth; }
    public String getM_gender() { return m_gender; }
    public void setM_gender(String m_gender) { this.m_gender = m_gender; }
    public String getM_phone() { return m_phone; }
    public void setM_phone(String m_phone) { this.m_phone = m_phone; }
    public String getM_email() { return m_email; }
    public void setM_email(String m_email) { this.m_email = m_email; }
    public String getM_datetime() { return m_datetime; }
    public void setM_datetime(String m_datetime) { this.m_datetime = m_datetime; }
    public String getM_role() { return m_role; }
    public void setM_role(String m_role) { this.m_role = m_role; }
    public String getM_status() { return m_status; }
    public void setM_status(String m_status) { this.m_status = m_status; }
    public String getM_profile_image() { return m_profile_image; }
    public void setM_profile_image(String m_profile_image) { this.m_profile_image = m_profile_image; }

    @Override
    public String toString() {
        return "Member [m_no=" + m_no + ", m_nickname=" + m_nickname + ", m_id=" + m_id
                + ", m_pw=" + m_pw + ", m_birth=" + m_birth + ", m_gender=" + m_gender
                + ", m_phone=" + m_phone + ", m_email=" + m_email + ", m_datetime=" + m_datetime + "]";
    }
}