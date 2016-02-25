require 'spec_helper'

describe GithubUrls do
  it 'has a version number' do
    expect(GithubUrls::VERSION).not_to be nil
  end

  it 'parses github urls' do
    [
      ['https://github.com/maxcdn/shml/', 'maxcdn/shml'],
      ['https://foo.github.io/bar', 'foo/bar'],
      ['git+https://github.com/hugojosefson/express-cluster-stability.git', 'hugojosefson/express-cluster-stability'],
      ['sughodke.github.com/linky.js/', 'sughodke/linky.js'],
      ['www.github.com/37point2/brainfuckifyjs', '37point2/brainfuckifyjs'],
      ['ssh://git@github.org:brozeph/node-craigslist.git', 'brozeph/node-craigslist'],
      ['ssh+git@github.com:omardelarosa/tonka-npm.git', 'omardelarosa/tonka-npm'],
      ['scm:svn:https://github.com/tanhaichao/top4j/tags/top4j-0.0.1', 'tanhaichao/top4j'],
      ['scm:${project.scm.vendor}:git@github.com:adamcin/maven-s3-wagon.git', 'adamcin/maven-s3-wagon'],
      ['scm:https://vert-x@github.com/purplefox/vert.x', 'purplefox/vert.x'],
      ['scm:https:https://github.com/vaadin/vaadin.git', 'vaadin/vaadin'],
      ['scm:https://github.com/daimajia/AndroidAnimations.git', 'daimajia/AndroidAnimations'],
      ['scm:http:http://NICTA@github.com/NICTA/scoobi.git', 'NICTA/scoobi'],
      ['scm:http:http://etorreborre@github.com/etorreborre/specs.git', 'etorreborre/specs'],
      ['scm:hg:https://github.com/wangenyong/EnAndroidLibrary', 'wangenyong/EnAndroidLibrary'],
      ['scm:hg:git://github.com/jesselong/muffero.git', 'jesselong/muffero'],
      ['scm:git:ssh@github.com:claudius108/maven-plugins.git', 'claudius108/maven-plugins'],
      ['scm:git|ssh://git@github.com/zinin/tomcat-redis-session.git', 'zinin/tomcat-redis-session'],
      ['scm:git:prasadpnair@github.com/Jamcracker/jit-core.git', 'Jamcracker/jit-core'],
      ['scm:git:scm:git:git://github.com/spring-projects/spring-integration.git', 'spring-projects/spring-integration'],
      ['scm:git:https://github.com/axet/sqlite4java', 'axet/sqlite4java'],
      ['scm:git:https://github.com/celum/db-tool.git', 'celum/db-tool'],
      ['scm:git:https://ffromm@github.com/jenkinsci/slave-setup-plugin.git', 'jenkinsci/slave-setup-plugin'],
      ['scm:git:github.com/yfcai/CREG.git', 'yfcai/CREG'],
      ['scm:git@github.com:urunimi/PullToRefreshAndroid.git', 'urunimi/PullToRefreshAndroid'],
      ['scm:git:github.com/larsrh/libisabelle.git', 'larsrh/libisabelle'],
      ['scm:git://github.com/lihaoyi/ajax.git', 'lihaoyi/ajax'],
      ['scm:git@github.com:ExpediaInc/ean-android.git', 'ExpediaInc/ean-android'],
      ['https://RobinQu@github.com/RobinQu/node-gear.git', 'RobinQu/node-gear'],
      ['https://taylorhakes@github.com/taylorhakes/promise-polyfill.git', 'taylorhakes/promise-polyfill'],
      ['https://hcnode.github.com/node-gitignore', 'hcnode/node-gitignore'],
      ['https://github.org/srcagency/js-slash-tail.git', 'srcagency/js-slash-tail'],
      ['https://gf3@github.com/gf3/IRC-js.git', 'gf3/IRC-js'],
      ['https://crcn:KQ3Lc6za@github.com/crcn/verify.js.git', 'crcn/verify.js'],
      ['https://bgrins.github.com/spectrum', 'bgrins/spectrum'],
      ['//github.com/dtrejo/report.git', 'dtrejo/report'],
      ['=https://github.com/amansatija/Cus360MavenCentralDemoLib.git', 'amansatija/Cus360MavenCentralDemoLib'],
      ['git+https://bebraw@github.com/bebraw/colorjoe.git', 'bebraw/colorjoe'],
      ['git:///github.com/NovaGL/homebridge-openremote.git', 'NovaGL/homebridge-openremote'],
      ['git://git@github.com/jballant/webpack-strip-block.git', 'jballant/webpack-strip-block'],
      ['git://github.com/2betop/yogurt-preprocessor-extlang.git', '2betop/yogurt-preprocessor-extlang'],
      ['git:/git://github.com/antz29/node-twister.git', 'antz29/node-twister'],
      ['git:/github.com/shibukawa/burrows-wheeler-transform.jsx.git', 'shibukawa/burrows-wheeler-transform.jsx'],
      ['git:git://github.com/alaz/mongo-scala-driver.git', 'alaz/mongo-scala-driver'],
      ['git:git@github.com:doug-martin/string-extended.git', 'doug-martin/string-extended'],
      ['git:github.com//dominictarr/level-couch-sync.git', 'dominictarr/level-couch-sync'],
      ['git:github.com/dominictarr/keep.git', 'dominictarr/keep'],
      ['git:https://github.com/vaadin/cdi.git', 'vaadin/cdi'],
      ['git@git@github.com:dead-horse/webT.git', 'dead-horse/webT'],
      ['git@github.com:agilemd/then.git', 'agilemd/then'],
      ['https : //github.com/alex101/texter.js.git', 'alex101/texter.js'],
      ['git@git.github.com:daddye/stitchme.git', 'daddye/stitchme'],
      ['github.com/1995hnagamin/hubot-achievements', '1995hnagamin/hubot-achievements'],
      ['git//github.com/divyavanmahajan/jsforce_downloader.git', 'divyavanmahajan/jsforce_downloader'],
      ['scm:git:https://michaelkrog@github.com/michaelkrog/filter4j.git', 'michaelkrog/filter4j'],
    ].each do |row|
      url, full_name = row
      result = GithubUrls.parse(url)
      expect(result).to eq(full_name)
    end
  end

  it "handles anchors" do
    full_name = 'michaelkrog/filter4j'
    url       = 'scm:git:https://michaelkrog@github.com/michaelkrog/filter4j.git#anchor'
    result    = GithubUrls.parse(url)

    expect(result).to eq(full_name)
  end

  it "handles querystrings" do
    full_name = 'michaelkrog/filter4j'
    url       = 'scm:git:https://michaelkrog@github.com/michaelkrog/filter4j.git?foo=bar&wut=wah'
    result    = GithubUrls.parse(url)

    expect(result).to eq(full_name)
  end

  it "handles brackets" do
    [
      ['[scm:git:https://michaelkrog@github.com/michaelkrog/filter4j.git]', 'michaelkrog/filter4j'],
      ['<scm:git:https://michaelkrog@github.com/michaelkrog/filter4j.git>', 'michaelkrog/filter4j'],
      ['(scm:git:https://michaelkrog@github.com/michaelkrog/filter4j.git)', 'michaelkrog/filter4j'],
    ].each do |row|
      url, full_name = row
      result = GithubUrls.parse(url)
      expect(result).to eq(full_name)
    end
  end

  it 'parses more github urls' do
    skip
    [
      ['git+ssh://gregoryfoster@github.com/stori_es-sdk-node.git', 'gregoryfoster/stori_es-sdk-node'],
      ['https://raw.github.com/zdne/spacegray-xcode/master/Space%20Gray.dvtcolortheme', 'zdne/spacegray-xcode'],
      ['scm:git:github.com:eskatos/javafx-maven-plugin.git/javafx-maven-plugin', 'eskatos/javafx-maven-plugin'],
      ['scm:git:https://${appverseweb.user.name}:${appverseweb.user.password}@github.com/Appverse/appverse-web.git/appverse-web-tools-pom/appverse-web-tools-jpa-ddl-generator-pom/appverse-web-tools-jpa-ddl-generator-plugin', 'Appverse/appverse-web'],
      ['scm:git:https//github.com/DozerMapper/dozer/dozer-spring', 'DozerMapper/dozer'],
      ['scm:git:https://michaelkrog@github.com/michaelkrog/filter4j.git/filter4j-core', 'michaelkrog/filter4j'],
      ['scm:git:https://matthieu-vergne@github.com/matthieu-vergne/Translation.git/translation-editor', 'matthieu-vergne/Translation'],
      ['scm:git:ssh@github.com:claudius108/kuberam.git/junit-tests', 'claudius108/kuberam'],
      ['scm:git:ssh//github.com/switchyard/core.git/switchyard-release/switchyard-release-as7', 'switchyard/core'],
      ['scm:git:ssh://git@ssh.github.com/dcm4che/jdbc-jboss-modules.git', 'dcm4che/jdbc-jboss-modules'],
      ['scm:git:ssh://git@ssh.github.com/dcm4che/dcm4che.git/dcm4che-ws-rs', 'dcm4che/dcm4che'],
      ['https://camlistore.org/third_party/github.com/go-sql-driver/mysql', 'go-sql-driver/mysql'],
      ['git://assemble.github.com/assemble/dry.git', 'assemble/dry'],
      ['git@Horsed-github.com:Horsed/chinaski.git', 'Horsed/chinaski']
    ].each do |row|
      url, full_name = row
      result = GithubUrls.parse(url)
      expect(result).to eq(full_name)
    end
  end

  it 'doesnt parses non-github urls' do
    [
      'https://google.com',
      'https://github.com/foo',
      'https://github.com',
      'https://foo.github.io'
    ].each do |url|
      result = GithubUrls.parse(url)
      expect(result).to eq(nil)
    end
  end
end
