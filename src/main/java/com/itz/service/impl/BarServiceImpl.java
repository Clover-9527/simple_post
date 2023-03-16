package com.itz.service.impl;

import com.itz.dao.BarDao;
import com.itz.model.Bar;
import com.itz.service.BarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BarServiceImpl implements BarService {

    @Autowired
    private BarDao barDao;

    @Override
    public List<Bar> getBarAll() {
        return barDao.getBarAll();
    }
}
