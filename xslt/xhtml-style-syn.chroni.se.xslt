<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:xhtml="http://www.w3.org/1999/xhtml"
              xmlns:syn="http://syn.chroni.se/2011"
              xmlns="http://www.w3.org/1999/xhtml"
              exclude-result-prefixes="xhtml syn"
              version="1.0">
  <xsl:output method="xml" version="1.0" encoding="UTF-8"
              doctype-public="-//W3C//DTD XHTML 1.1//EN"
              doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
              indent="no"
              media-type="application/xhtml+xml" />

  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="xhtml:pre" />

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xhtml:head">
    <xsl:copy>
      <link href="/css/syn.chroni.se" rel="stylesheet" type="text/css" />
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xhtml:title">
    <title>syn.chroni.se :: <xsl:apply-templates select="@*|node()" /></title>
  </xsl:template>

  <xsl:template match="xhtml:body">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <h1>http://syn.chroni.se/ :: <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:title"/></h1>
      <p>Fast, accurate time information. No fuss, no bull, no advertising.</p>
      <ul>
        <li>Hop onto freenode's #synchronise for blame, praise or feature requests.</li>
	<li>Hover over any element (including this one) to get more information.</li>
	<li>Ever needed to set up an event with someone from a different area? Ever have people be late for that event because they think they're on time, but they're just not in the right time zone? Or their clock is off by a solid fifteen minutes? Accidentally set the wrong time on your server, because someone set the wrong time zone?</li>
	<li>I know I have. This site fixes that by giving everyone the same time source. It might not be the exact, current time, but as long as everyone is using this site, you're set. It even works on a console when all you have is your trusty text browser. With regular browsers, it's smart enough to compensate for skewed clocks by calculating (and showing) the local clock's drift and adjusting the time accordingly.</li>
	<li><a href="now">Current Time</a></li>
	<li><a href="irc://irc.freenode.org/synchronise">IRC</a></li>
	<li><a href="source-code">Source Code</a></li>
      </ul>
      <xsl:apply-templates select="node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xhtml:h1">
    <h2>
      <xsl:apply-templates select="@*|node()" />
    </h2>
  </xsl:template>
  <xsl:template match="xhtml:h2">
    <h3>
      <xsl:apply-templates select="@*|node()" />
    </h3>
  </xsl:template>
  <xsl:template match="xhtml:h3">
    <h4>
      <xsl:apply-templates select="@*|node()" />
    </h4>
  </xsl:template>
  <xsl:template match="xhtml:h4">
    <h5>
      <xsl:apply-templates select="@*|node()" />
    </h5>
  </xsl:template>
  <xsl:template match="xhtml:h5">
    <h6>
      <xsl:apply-templates select="@*|node()" />
    </h6>
  </xsl:template>
</xsl:stylesheet>

