package com.foxconn.fii.common.utils;

import com.jcraft.jsch.*;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

@Slf4j
@UtilityClass
public class SftpUtils {

    public static ChannelSftp createChannel(String host, int port, String username, String password) throws JSchException {
        JSch jsch = new JSch();
        jsch.setKnownHosts("/Users/john/.ssh/known_hosts");

        Session jschSession = jsch.getSession(username, host);
        java.util.Properties config = new java.util.Properties();
        config.put("StrictHostKeyChecking", "no");
        jschSession.setConfig(config);
        jschSession.setPort(port);
        jschSession.setPassword(password);
        jschSession.connect();
        return (ChannelSftp) jschSession.openChannel("sftp");
    }

    public static boolean downloadSftp(String host, int port, String username, String password, String fileInPath, String fileOutPath) {
        fileInPath = fileInPath.replace("\\\\", "/").replace("\\", "/");
        fileOutPath = fileOutPath.replace("\\\\", "/").replace("\\", "/");
        ChannelSftp channelSftp = null;
        try {
            channelSftp = createChannel(host, port, username, password);
        } catch (JSchException e) {
            System.out.println("Try setup SFTP-----------" + e);
            return false;
        }
        try {
            channelSftp.connect();
        } catch (JSchException e) {
            System.out.println("Try connect to SFTP-----------" + e);
            return false;
        }
        try {
            channelSftp.get(fileInPath, fileOutPath);
            System.out.println("Download Complete");
        } catch (SftpException e) {
            System.out.println("Try download file from SFTP-----------" + e);
            return false;
        }
        channelSftp.exit();
        return true;
    }

    public static boolean uploadSftp(String host, int port, String username, String password, String localFile, String sftpFile) {
        localFile = localFile.replace("\\\\", "/").replace("\\", "/");
        sftpFile = sftpFile.replace("\\\\", "/").replace("\\", "/");
        ChannelSftp channelSftp = null;
        try {
            channelSftp = createChannel(host, port, username, password);
        } catch (JSchException e) {
            System.out.println("Try setup SFTP-----------" + e);
            return false;
        }
        try {
            channelSftp.connect();
        } catch (JSchException e) {
            System.out.println("Try connect to SFTP-----------" + e);
            return false;
        }
        String[] folders = sftpFile.split("/");
        try {
            for (String folder : folders) {
                if (folder.length() > 0) {
                    try {
                        channelSftp.cd(folder);
                    } catch (SftpException e) {
                        channelSftp.mkdir(folder);
                        channelSftp.cd(folder);
                        System.out.println("create folder success------" + folder);
                    }
                }
            }
        } catch (SftpException sftpException) {
            System.out.println("uploadSftp--------try create folder");
            return false;
        }
        try {
            channelSftp.put(localFile, sftpFile);
            System.out.println("Upload Complete");
        } catch (SftpException e) {
            System.out.println("Try upload file from SFTP-----------" + e.getMessage());
            return false;
        }
        channelSftp.exit();
        return true;
    }

    public static boolean uploadSftp(String host, int port, String username, String password, InputStream localFile, String sftpFile) {
        sftpFile = sftpFile.replace("\\\\", "/").replace("\\", "/");
        ChannelSftp channelSftp = null;
        try {
            channelSftp = createChannel(host, port, username, password);
        } catch (JSchException e) {
            System.out.println("Try setup SFTP-----------" + e);
            return false;
        }
        try {
            channelSftp.connect();
        } catch (JSchException e) {
            System.out.println("Try connect to SFTP-----------" + e);
            return false;
        }
        String[] folders = sftpFile.split("/");
        try {
            for (String folder : folders) {
                if (folder.length() > 0) {
                    try {
                        channelSftp.cd(folder);
                    } catch (SftpException e) {
                        channelSftp.mkdir(folder);
                        channelSftp.cd(folder);
                        System.out.println("create folder success------" + folder);
                    }
                }
            }
        } catch (SftpException sftpException) {
            System.out.println("uploadSftp--------try create folder");
            return false;
        }
        try {
            channelSftp.put(localFile, sftpFile);
            System.out.println("Upload Complete");
        } catch (SftpException e) {
            System.out.println("Try upload file from SFTP-----------" + e);
            return false;
        }
        channelSftp.exit();
        return true;
    }

    public static boolean uploadDirectorySftp(String host, int port, String username, String password, String sourcePath, String destinationPath) {
        sourcePath = sourcePath.replace("\\\\", "/").replace("\\", "/");
        destinationPath = destinationPath.replace("\\\\", "/").replace("\\", "/");
        ChannelSftp channelSftp = null;
        try {
            channelSftp = createChannel(host, port, username, password);
        } catch (JSchException e) {
            System.out.println("Try setup SFTP-----------" + e);
            return false;
        }
        try {
            channelSftp.connect();
        } catch (JSchException e) {
            System.out.println("Try connect to SFTP-----------" + e);
            return false;
        }
        String[] folders = destinationPath.split("/");
        try {
            for (String folder : folders) {
                if (folder.length() > 0) {
                    try {
                        channelSftp.cd(folder);
                    } catch (SftpException e) {
                        channelSftp.mkdir(folder);
                        channelSftp.cd(folder);
                        System.out.println("create folder success------" + folder);
                    }
                }
            }
        } catch (SftpException sftpException) {
            System.out.println("uploadSftp--------try create folder----------" + sftpException);
            return false;
        }
        File sourceFile = new File(sourcePath);
        if (sourceFile.isFile()) {
            if (!sourceFile.getName().startsWith(".")) {
                try {
                    channelSftp.put(new FileInputStream(sourceFile), sourceFile.getName(), ChannelSftp.OVERWRITE);
                } catch (FileNotFoundException | SftpException e) {
                    System.out.println("uploadDirectorySftp---try upload file---" + e);
                    return false;
                }
            }
        } else {
            File[] files = sourceFile.listFiles();
            if (files != null && !sourceFile.getName().startsWith(".")) {
                SftpATTRS attrs = null;
                try {
                    attrs = channelSftp.stat(destinationPath + "/" + sourceFile.getName());
                } catch (Exception e) {
                    System.out.println(destinationPath + "/" + sourceFile.getName() + " not found");
                    System.out.println("Creating dir " + sourceFile.getName());
                    try {
                        channelSftp.mkdir(sourceFile.getName());
                    } catch (SftpException sftpException) {
                        System.out.println("Try create folder----------" + sftpException);
                        return false;
                    }
                }
                for (File f : files) {
                    uploadDirectorySftp(host, port, username, password, f.getAbsolutePath(), destinationPath + "/" + sourceFile.getName());
                }
            }
        }
        return true;
    }

}
