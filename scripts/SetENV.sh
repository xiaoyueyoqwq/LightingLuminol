prop() {
  grep "^[[:space:]]*${1}" gradle.properties | cut -d'=' -f2 | sed 's/^[[:space:]]*//; s/\r//'
}

project_id="lightingluminol"
project_id_b="LightingLuminol"

commitid=$(git log --pretty='%h' -1)
mcversion=$(prop mcVersion)
grdversion=$(prop version)
preVersion=$(prop preVersion)
release_tag="$mcversion-$commitid"
jarName="$project_id-$mcversion-paperclip.jar"
jarName_dir="build/libs/$jarName"
make_latest=$([ $preVersion = "true" ] && echo "false" || echo "true")

mv build/libs/$project_id_b-paperclip-$grdversion-reobf.jar build/libs/$jarName
mv build/libs/$project_id_b-bundler-$grdversion-reobf.jar build/libs/$project_id-$mcversion-bundler.jar

echo "project_id=$project_id" >> $GITHUB_ENV
echo "project_id_b=$project_id_b" >> $GITHUB_ENV
echo "commit_id=$commitid" >> $GITHUB_ENV
echo "commit_msg=$(git log --pretty='> [%h] %s' -1)" >> $GITHUB_ENV
echo "mcversion=$mcversion" >> $GITHUB_ENV
echo "pre=$preVersion" >> $GITHUB_ENV
echo "tag=$release_tag" >> $GITHUB_ENV
echo "jar=$jarName" >> $GITHUB_ENV
echo "jar_dir=$jarName_dir" >> $GITHUB_ENV
echo "make_latest=$make_latest" >> $GITHUB_ENV