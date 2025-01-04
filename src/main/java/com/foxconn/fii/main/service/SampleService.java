package com.foxconn.fii.main.service;

import java.io.File;
import java.util.List;

public interface SampleService {

    void readTextFromFolder(String folderPath);

    void readTextFromExcel(File file);

    List<String> generateList(int limit);
}
