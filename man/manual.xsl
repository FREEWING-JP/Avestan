<?xml version="1.0" encoding="Shift_JIS"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output 
	method="html"
	media-type="text/html"
	doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
	encoding="Shift_JIS"/>

<xsl:template match="/manual">
	<html lang="ja">
		<head>
			<title><xsl:value-of select="@title"/></title>
			<meta http-equiv="Content-Style-Type" content="text/css"/>
			<link rel="stylesheet" type="text/css" href="manual.css"/>
		</head>
		<body>
			<h1><xsl:value-of select="@title"/></h1>
			<ul>
				<xsl:apply-templates mode="index"/>
			</ul>
			<xsl:apply-templates/>
		</body>
	</html>
</xsl:template>

<!-- ���� -->
<xsl:template match="//manual/*" mode="index">
	<li><a href="#{generate-id(.)}"><xsl:value-of select="@name"/></a></li>
</xsl:template>

<!-- �T�v -->
<xsl:template match="brief">
	<h2 id="{generate-id(.)}"><xsl:value-of select="@name"/></h2>
	<table>
		<tr><td nowrap="">�^�C�g��</td><td><xsl:apply-templates select="what"/></td></tr>
		<tr><td nowrap="">�o�[�W����</td><td><xsl:apply-templates select="version"/></td></tr>
		<tr><td nowrap="">���t</td><td><xsl:apply-templates select="when"/></td></tr>
		<tr><td nowrap="">���쌠��</td><td><xsl:apply-templates select="who"/></td></tr>
		<tr><td nowrap="">���[��</td><td><a href="mailto:{mailto}"><xsl:apply-templates select="mailto"/></a></td></tr>
		<tr><td nowrap="">URL</td><td><a href="{url}"><xsl:apply-templates select="url"/></a></td></tr>
		<tr><td nowrap="">�J����</td><td><xsl:apply-templates select="env-dev"/></td></tr>
		<tr><td nowrap="">�����</td><td><xsl:apply-templates select="env-run"/></td></tr>
		<tr><td nowrap="">���C�Z���X</td><td><xsl:apply-templates select="licence"/></td></tr>
	</table>
</xsl:template>

<!-- ���� -->
<xsl:template match="features">
	<h2 id="{generate-id(.)}"><xsl:value-of select="@name"/></h2>
	<ul>
		<xsl:apply-templates select="feature"/>
	</ul>
</xsl:template>

<xsl:template match="feature">
	<li><xsl:apply-templates/></li>
</xsl:template>

<!-- �͂��߂� -->
<xsl:template match="startup">
	<h2 id="{generate-id(.)}"><xsl:value-of select="@name"/></h2>
	<div>
		<h3><xsl:value-of select="install/@name"/></h3>
		<div><xsl:apply-templates select="install/*"/></div>
	</div>
	<div>
		<h3><xsl:value-of select="update/@name"/></h3>
		<div><xsl:apply-templates select="update/*"/></div>
	</div>
	<div>
		<h3><xsl:value-of select="uninstall/@name"/></h3>
		<div><xsl:apply-templates select="uninstall/*"/></div>
	</div>
</xsl:template>

<!-- �g���� -->
<xsl:template match="usage">
	<h2 id="{generate-id(.)}"><xsl:value-of select="@name"/></h2>
	<xsl:apply-templates/>
</xsl:template>

<!-- �R�}���h�e�[�u�� -->
<xsl:template match="commands">
	<h2 id="{generate-id(.)}"><xsl:value-of select="@name"/></h2>
	<div><xsl:apply-templates select="description"/></div>
	<table>
		<tr><th>���O</th><th>����</th></tr>
		<xsl:apply-templates select="document(file)//command-table/*"/>
	</table>
</xsl:template>

<!-- �R�}���h -->
<xsl:template match="command">
	<tr>
		<td class="command"><xsl:apply-templates select="name"/></td>
		<td><xsl:apply-templates select="description"/></td>
	</tr>
</xsl:template>

<!-- �X�V���� -->
<xsl:template match="changelog">
	<h2 id="{generate-id(.)}"><xsl:value-of select="@name"/></h2>
	<p>
		<span class="new">�V�K</span>�@<span class="refine">���P</span>�@<span class="bugfix">�o�O�쏜</span>�@<span class="internal">��������</span>�@
		<a href="history.html">�ߋ��̍X�V����</a>
	</p>
	<dl>
		<xsl:apply-templates select="document(file)//log-table/*"/>
	</dl>
</xsl:template>

<!-- ���O -->
<xsl:template match="log">
	<dt>
		<xsl:value-of select="@version"/>
	</dt>
	<xsl:for-each select="entry">
		<dd>
			<span class="{type}">
				<xsl:choose>
					<xsl:when test="type='new'">�� </xsl:when>
					<xsl:when test="type='refine'">�� </xsl:when>
					<xsl:when test="type='bugfix'">�� </xsl:when>
					<xsl:when test="type='internal'">�� </xsl:when>
					<xsl:otherwise>
						<xsl:message terminate="yes">
							<xsl:value-of select="type"/> �͕s���ł��B
						</xsl:message>
					</xsl:otherwise>
				</xsl:choose>
			</span>
			<xsl:apply-templates select="description"/>
		</dd>
	</xsl:for-each>
</xsl:template>

<xsl:template match="forum">
	<a href="http://lamoo.s53.xrea.com/forum/index.php?all={@id}">[<xsl:value-of select="@id"/>]</a>
</xsl:template>

<xsl:template match="a">
	<a href="{@href}">
		<xsl:choose>
			<xsl:when test="node()">
				<xsl:apply-templates /> 
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@href" /> 
			</xsl:otherwise>
		</xsl:choose>
	</a>
</xsl:template>

<!-- ��{�I�ɂ̓^�O�����̂܂ܕ\������ -->
<xsl:template match="node()">
	<xsl:copy>
		<xsl:for-each select="@*"><xsl:copy/></xsl:for-each>
		<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
