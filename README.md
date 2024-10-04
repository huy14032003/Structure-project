# SAMPLE SYSTEM Project for create new project

# 1. Configuration for new project
#### 1.1 Create and clone `new-project`
Create `new-project` on git and clone it 
```
git clone https://fiisw-cns.myfiinet.com/git/new-project.git
```

#### 1.2 Add remote `sample-system`
Add remote `sample-system` and merge into current. 

If occurred error 
```
Could Not Merge sample-system/master: refusing to merge unrelated histories
``` 
please run command on terminal
```
git pull sample-system master --allow-unrelated-histories
```

#### 1.3 Change name of project
##### 1.3.1 In pom.xml
Change project name
```
<groupId>com.foxconn.fii</groupId>
<artifactId>sample-system</artifactId>
<version>0.0.1</version>
<packaging>war</packaging>

<name>sample-system</name>
```

##### 1.3.2 In application-*.yml
Change port, context-path, domain, logging, etc...
```
server:
  http.port: 8000
  port: 18000
  domain: https://10.224.81.70:6443/sample-system
  servlet:
    context-path: /sample-system
    session:
      cookie:
        name: SAMPLE_SSESSION
      timeout: 30m

spring:
  jmx:
    default-domain: sample-system

path:
  data: D:/tiennd/data/project/sample-system/

logging:
  path: logs/sample-system

```

##### 1.3.2 In com.foxconn.fii.config.ApplicationConstant.java
Change project name for notify source 
```
public static final String APPLICATION_NAME = "SAMPLE-SYSTEM";

```

# 2. Intellij configuration maven
#### 2.1 Build first times project then right click in pom.xml file to maven > reimport
```
clean packing
```
#### 2.2 Run project
```
clean spring-boot:run
```
#### 2.3 Building project with environment alpha
```
clean package -Dmaven.test.skip=true -Palpha
```

# 3. Run unit test
#### 3.1 Create unit test in folder src.test.java
```
@Test
public void mainTest() {
    // TODO something
}
```