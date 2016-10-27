#!/bin/bash

mkdir -p ~/.sbt/0.13/
touch ~/.sbt/0.13/sonatype.sbt
echo 'credentials += Credentials("Sonatype Nexus Repository Manager",' >> ~/.sbt/0.13/sonatype.sbt
echo '        "oss.sonatype.org",' >> ~/.sbt/0.13/sonatype.sbt
echo '        "'$WERCKER_SBT_TO_MAVEN_CENTRAL_USER'",' >> ~/.sbt/0.13/sonatype.sbt
echo '        "'$WERCKER_SBT_TO_MAVEN_CENTRAL_PASSWORD'")' >> ~/.sbt/0.13/sonatype.sbt

touch ~/.private.key
echo -e $WERCKER_SBT_TO_MAVEN_CENTRAL_PRIVATE_KEY > ~/.private.key
gpg --import ~/.private.key
rm -rf ~/.private.key

mkdir -p ~/.sbt/0.13/plugins/
touch ~/.sbt/0.13/plugins/plugins.sbt
echo 'addSbtPlugin("org.xerial.sbt" % "sbt-sonatype" % "1.1")' >> ~/.sbt/0.13/plugins/plugins.sbt
echo '' >> ~/.sbt/0.13/plugins/plugins.sbt
echo 'addSbtPlugin("com.jsuereth" % "sbt-pgp" % "1.0.0")' >> ~/.sbt/0.13/plugins/plugins.sbt

if [[ "$WERCKER_SBT_TO_MAVEN_CENTRAL_DESTINATION" == "RELEASE" ]]; then
    echo "$WERCKER_SBT_TO_MAVEN_CENTRAL_PASSPHRASE" | sbt +publishSigned
else
    echo "$WERCKER_SBT_TO_MAVEN_CENTRAL_PASSPHRASE" | sbt +publishSnapshotSigned
fi


if [[ "$WERCKER_SBT_TO_MAVEN_CENTRAL_UNATTENDED" == "true" ]]; then
    echo "Closing and releasing artefact version"
fi
