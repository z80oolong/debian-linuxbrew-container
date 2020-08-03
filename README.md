# debian-linuxbrew-container -- Linuxbrew が導入された Debian Jessie の Docker コンテナ

## はじめに

この [Docker][DOCK] コンテナは、 Linux のディストリビューションの一つである [Debian Jessie][DEBI] をベースに、ソースコードのビルドに基づくパッケージの導入システムである [Linuxbrew][BREW] を導入した [Docker][DOCK] コンテナです。

また、この Docker コンテナには、各種 Linux ディストリビューションに依存せず、インストールを行うこと無くアプリケーションを起動させることが出来るパッケージ形式である [AppImage パッケージファイル][APPI]を生成するための [linuxdeploy][LDEP] も同時に導入しています。

## Docker コンテナのビルド方法

まず最初に、 [Docker][DOCK] コンテナの公式のドキュメントである "[Docker のインストール — Docker-docs-ja 17.06.Beta ドキュメント][DCK1]" のページ等を参考にして、 [tmux][TMUX] の [AppImage ファイル][APPI]を生成するための端末に Docker コンテナ環境を構築します。

そして、本リポジトリ内のシェルスクリプト ```build-appimage.sh``` を以下の通りに起動します。

```
  $ ./build-container.sh
```

以上で、 [Debian Jessie][DEBI] をベースに、[Linuxbrew][BREW] を導入した [Docker][DOCK] コンテナが作成されます。

## 使用条件

このリポジトリに含まれる Dockerfile 及び [Docker][DOCK] コンテナを作成する為の各種スクリプトファイルは、 [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] が著作権を有し、 [MIT ライセンス][MITL]に基づいて配布されるものとします。

本リポジトリの使用条件の詳細については、本リポジトリに同梱する ```LICENSE``` を参照して下さい。

<!-- 外部リンク一覧 -->

[DOCK]:https://www.docker.io/
[DCK1]:http://docs.docker.jp/engine/installation/
[APPI]:https://appimage.org/
[DEBI]:https://www.debian.org/
[BREW]:https://linuxbrew.sh/
[LDEP]:https://github.com/linuxdeploy/linuxdeploy
[ZOOL]:http://zool.jpn.org/
[MITL]:https://opensource.org/licenses/mit-license.php
