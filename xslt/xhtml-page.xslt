<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:xhtml="http://www.w3.org/1999/xhtml"
              xmlns:syn="http://syn.chroni.se/2011"
              xmlns="http://www.w3.org/1999/xhtml"
              xmlns:date="http://exslt.org/dates-and-times"
              version="1.0">
  <xsl:output method="xml" version="1.0" encoding="UTF-8"
              doctype-public="-//W3C//DTD XHTML 1.1//EN"
              doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
              indent="no"
              media-type="application/xhtml+xml" />

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="digital-clock">
    <xsl:param name="seconds">0</xsl:param>
    <xsl:param name="seconds1">60</xsl:param>
    <xsl:param name="seconds2">3600</xsl:param>
    <xsl:param name="seconds3">86400</xsl:param>
    <xsl:param name="secondsPerDay">86400</xsl:param>

    <xsl:variable name="secondsToday" select="$seconds mod $secondsPerDay" />

    <xsl:choose>
      <xsl:when test="/syn:page[@js='yes']">
        <p id="clock-digital"><xsl:value-of select="format-number(floor($secondsToday mod $secondsPerDay div $seconds2),'00')" />:<xsl:value-of select="format-number(floor($secondsToday mod $seconds2 div $seconds1),'00')" />:<xsl:value-of select="format-number($secondsToday mod $seconds1,'00')" /></p>
      </xsl:when>
      <xsl:otherwise>
        <p><xsl:value-of select="format-number(floor($secondsToday mod $secondsPerDay div $seconds2),'00')" />:<xsl:value-of select="format-number(floor($secondsToday mod $seconds2 div $seconds1),'00')" />:<xsl:value-of select="format-number($secondsToday mod $seconds1,'00')" /></p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="syn:page">
    <html>
      <head>
        <title><xsl:value-of select="@name" /></title>
        <xsl:choose>
          <xsl:when test="/syn:page[@js='yes']">
	    <script type="text/javascript" src="/js/update-date-time"></script>
	  </xsl:when>
	  <xsl:otherwise>
            <script type="text/javascript">location.href=location.href.replace(/(x?html)\//,'$1+js/');</script>
	  </xsl:otherwise>
        </xsl:choose>
      </head>
      <body>
        <xsl:apply-templates select="node()" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="syn:clock[@render='analog']">
    <div>
      <h1>Clock [GMT, 12h]</h1>
      <p>
        <xsl:choose>
          <xsl:when test="/syn:page[@js='yes']">
            <object data="/svg+js/clock,{@render}" type="image/svg+xml">An analog clock. You are likely seeing this message because your browser does not support SVG graphics.</object>
          </xsl:when>
          <xsl:otherwise>
            <img src="/svg/clock,{@render}" alt="an analog clock (requires a web browser with support for SVGs)" />
          </xsl:otherwise>
        </xsl:choose>
      </p>
      <p class="explanation">This is an analog clock displaying the current time in GMT.</p>
    </div>
  </xsl:template>

  <xsl:template match="syn:clock[@render='digital']">
    <div>
      <h1>Clock [GMT, 24h]</h1>
      <xsl:call-template name="digital-clock">
        <xsl:with-param name="seconds">
          <xsl:value-of select="date:seconds()" />
        </xsl:with-param>
      </xsl:call-template>
      <p class="explanation">This clock is displaying the current time in GMT.</p>
    </div>
  </xsl:template>

  <xsl:template match="syn:date-time[@calendar='unix'][@clock='unix']">
    <div>
      <h1>Unix time</h1>
      <xsl:choose>
        <xsl:when test="/syn:page[@js='yes']">
          <p id="unix-time"><xsl:value-of select="date:seconds()" /></p>
        </xsl:when>
        <xsl:otherwise>
          <p><xsl:value-of select="date:seconds()" /></p>
        </xsl:otherwise>
      </xsl:choose>
      <p class="explanation">This is the number of seconds that have passed since the first of January, 1970 at 00:00:00 GMT, excluding leap seconds.</p>
    </div>
  </xsl:template>

  <xsl:template match="syn:information[@type='clock-drift']">
    <div>
      <h1>Clock drift</h1>
      <xsl:choose>
        <xsl:when test="/syn:page[@js='yes']">
          <p id="clock-drift">Not yet determined</p>
	  <p class="explanation">This is the number of seconds that your computer's and the server's clock differ. Note that this is only a rough estimate, influenced by the latency of the server and your connection.</p>
        </xsl:when>
        <xsl:otherwise>
          <p>Unavailable</p>
	  <p class="explanation">Determining the difference between your computer's and server's clock requires JavaScript to be enabled in your browser and that the site is allowed to execute scripts.</p>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="syn:information[@type='time-zone']">
    <div>
      <h1>Time zone</h1>
      <xsl:choose>
        <xsl:when test="/syn:page[@js='yes']">
          <p id="time-zone">Not yet determined</p>
	  <p class="explanation">This is the local time zone, as set in your computer's settings. As customary, this is expressed as an offset to GMT, in hours.</p>
        </xsl:when>
        <xsl:otherwise>
          <p>Unavailable</p>
	  <p class="explanation">Determining the local time zone requires JavaScript to be enabled in your browser and that the site is allowed to execute scripts.</p>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
</xsl:stylesheet>

