package com.itz.dao;

import com.itz.model.Bar;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BarDao {
    @Select("select bar_id barId,bar_name barName from bar order by bar_name")
    List<Bar> getBarAll();
}
