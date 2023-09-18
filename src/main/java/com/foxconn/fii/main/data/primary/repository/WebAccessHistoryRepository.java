package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.WebAccessHistory;
import com.foxconn.fii.main.data.primary.model.entity.WebLogPath;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WebAccessHistoryRepository extends JpaRepository<WebAccessHistory, Integer> {

}

