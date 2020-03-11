# za: https://github.com/timgifford/maven-buildtime-extension

VERSION=2.0.3
mvn -q dependency:get -Dartifact="co.leantechniques:maven-buildtime-extension:$VERSION"
mvn compile -Dmaven.ext.class.path="$HOME/.m2/repository/co/leantechniques/maven-buildtime-extension/$VERSION/maven-buildtime-extension-$VERSION.jar" -Dbuildtime.output.log=true
