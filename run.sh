#!/bin/bash

mkdir -p ~/.sbt/1.0/
touch ~/.sbt/1.0/sonatype.sbt
echo 'credentials += Credentials("Sonatype Nexus Repository Manager",' >> ~/.sbt/1.0/sonatype.sbt
echo '        "oss.sonatype.org",' >> ~/.sbt/1.0/sonatype.sbt
echo '        "'$WERCKER_SBT_TO_MAVEN_CENTRAL_USER'",' >> ~/.sbt/1.0/sonatype.sbt
echo '        "'$WERCKER_SBT_TO_MAVEN_CENTRAL_PASSWORD'")' >> ~/.sbt/1.0/sonatype.sbt

touch ~/.private.key
echo -e $WERCKER_SBT_TO_MAVEN_CENTRAL_PRIVATE_KEY > ~/.private.key
gpg --import ~/.private.key
rm -rf ~/.private.key

mkdir -p ~/.sbt/1.0/plugins/
touch ~/.sbt/1.0/plugins/plugins.sbt
echo 'addSbtPlugin("org.xerial.sbt" % "sbt-sonatype" % "2.3")' >> ~/.sbt/1.0/plugins/plugins.sbt
echo '' >> ~/.sbt/1.0/plugins/plugins.sbt
echo 'addSbtPlugin("com.jsuereth" % "sbt-pgp" % "1.1.0")' >> ~/.sbt/1.0/plugins/plugins.sbt

if [[ "$WERCKER_SBT_TO_MAVEN_CENTRAL_DESTINATION" == "RELEASE" ]]; then
    echo "$WERCKER_SBT_TO_MAVEN_CENTRAL_PASSPHRASE" | sbt +publishSigned
else
    echo "$WERCKER_SBT_TO_MAVEN_CENTRAL_PASSPHRASE" | sbt +publishSnapshot
fi


if [[ "$WERCKER_SBT_TO_MAVEN_CENTRAL_UNATTENDED" == "true" ]]; then
    echo "Closing and releasing artefact version"
fi
