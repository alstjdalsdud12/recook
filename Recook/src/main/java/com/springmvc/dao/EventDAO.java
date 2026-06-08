package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.Event;
import com.springmvc.util.DBConnection;

public class EventDAO {

    public List<Event> getEventList() {

        List<Event> list =
                new ArrayList<>();

        String sql =
                "select * from event order by e_no desc";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Event event =
                        new Event();

                event.setE_no(
                        rs.getInt("e_no"));

                event.setE_title(
                        rs.getString("e_title"));

                event.setE_desc(
                        rs.getString("e_desc"));

                event.setE_period(
                        rs.getString("e_period"));

                event.setE_reward(
                        rs.getString("e_reward"));

                event.setE_method(
                        rs.getString("e_method"));

                event.setE_icon(
                        rs.getString("e_icon"));

                event.setE_badge(
                        rs.getString("e_badge"));

                list.add(event);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }

    public Event getEventDetail(
            int e_no) {

        Event event =
                null;

        String sql =
                "select * from event where e_no=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(
                    1,
                    e_no);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                event =
                        new Event();

                event.setE_no(
                        rs.getInt("e_no"));

                event.setE_title(
                        rs.getString("e_title"));

                event.setE_desc(
                        rs.getString("e_desc"));

                event.setE_period(
                        rs.getString("e_period"));

                event.setE_reward(
                        rs.getString("e_reward"));

                event.setE_method(
                        rs.getString("e_method"));

                event.setE_icon(
                        rs.getString("e_icon"));

                event.setE_badge(
                        rs.getString("e_badge"));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return event;
    }
    
 // 이벤트 등록
    public void insert(Event event) {
        String sql = "INSERT INTO event (e_title, e_desc, e_period, e_reward, e_method, e_icon, e_badge) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, event.getE_title());
            ps.setString(2, event.getE_desc());
            ps.setString(3, event.getE_period());
            ps.setString(4, event.getE_reward());
            ps.setString(5, event.getE_method());
            ps.setString(6, event.getE_icon());
            ps.setString(7, event.getE_badge());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 이벤트 수정
    public void update(Event event) {
        String sql = "UPDATE event SET e_title=?, e_desc=?, e_period=?, e_reward=?, e_method=?, e_icon=?, e_badge=? WHERE e_no=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, event.getE_title());
            ps.setString(2, event.getE_desc());
            ps.setString(3, event.getE_period());
            ps.setString(4, event.getE_reward());
            ps.setString(5, event.getE_method());
            ps.setString(6, event.getE_icon());
            ps.setString(7, event.getE_badge());
            ps.setInt(8, event.getE_no());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 이벤트 삭제
    public void delete(int e_no) {
        String sql = "DELETE FROM event WHERE e_no=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, e_no);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}