<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:svg="http://www.w3.org/2000/svg"
              xmlns:syn="http://syn.chroni.se/2011"
              xmlns="http://www.w3.org/2000/svg"
              xmlns:date="http://exslt.org/dates-and-times"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              version="1.0">
  <xsl:output method="xml" version="1.0" encoding="UTF-8"
              doctype-public="-//W3C//DTD SVG 1.1//EN"
              doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
              indent="no"
              media-type="image/svg+xml" />

  <xsl:template name="analog-clock">
    <xsl:param name="seconds">0</xsl:param>
    <xsl:param name="seconds1">60</xsl:param>
    <xsl:param name="seconds2">3600</xsl:param>
    <xsl:param name="seconds3">43200</xsl:param>
    <xsl:param name="secondsPerDay">86400</xsl:param>

    <xsl:variable name="secondsToday" select="$seconds mod $secondsPerDay" />

    <defs>
    <svg viewBox="0 0 1000 1000" id="face">
    <defs>
    <xsl:choose>
      <xsl:when test="/syn:page[@js='yes']">
        <script type="text/javascript" xlink:href="/js/update-date-time"></script>
      </xsl:when>
    </xsl:choose>
    <line id="cursor" x1="500" y1="0" x2="500" y2="1000" style="stroke:black;stroke-width:1" />
    <line id="markA" x1="500" y1="50" x2="500" y2="75" style="stroke:black;stroke-width:1" />
    <line id="markB" x1="500" y1="50" x2="500" y2="60" style="stroke:black;stroke-width:1" />
    <line id="markC" x1="500" y1="25" x2="500" y2="50" style="stroke:black;stroke-width:1" />
    <line id="markD" x1="500" y1="40" x2="500" y2="50" style="stroke:black;stroke-width:1" />
    <g id="gridringA">
    <use xlink:href="#markA" transform="rotate(0,500,500)" />
    <use xlink:href="#markA" transform="rotate(30,500,500)" />
    <use xlink:href="#markA" transform="rotate(60,500,500)" />
    <use xlink:href="#markA" transform="rotate(90,500,500)" />
    <use xlink:href="#markA" transform="rotate(120,500,500)" />
    <use xlink:href="#markA" transform="rotate(150,500,500)" />
    <use xlink:href="#markA" transform="rotate(180,500,500)" />
    <use xlink:href="#markA" transform="rotate(210,500,500)" />
    <use xlink:href="#markA" transform="rotate(240,500,500)" />
    <use xlink:href="#markA" transform="rotate(270,500,500)" />
    <use xlink:href="#markA" transform="rotate(300,500,500)" />
    <use xlink:href="#markA" transform="rotate(330,500,500)" />
    </g>
    <g id="gridringB">
    <use xlink:href="#markB" transform="rotate(0,500,500)" />
    <use xlink:href="#markB" transform="rotate(30,500,500)" />
    <use xlink:href="#markB" transform="rotate(60,500,500)" />
    <use xlink:href="#markB" transform="rotate(90,500,500)" />
    <use xlink:href="#markB" transform="rotate(120,500,500)" />
    <use xlink:href="#markB" transform="rotate(150,500,500)" />
    <use xlink:href="#markB" transform="rotate(180,500,500)" />
    <use xlink:href="#markB" transform="rotate(210,500,500)" />
    <use xlink:href="#markB" transform="rotate(240,500,500)" />
    <use xlink:href="#markB" transform="rotate(270,500,500)" />
    <use xlink:href="#markB" transform="rotate(300,500,500)" />
    <use xlink:href="#markB" transform="rotate(330,500,500)" />
    </g>
    <g id="gridringC">
    <use xlink:href="#markC" transform="rotate(0,500,500)" />
    <use xlink:href="#markC" transform="rotate(30,500,500)" />
    <use xlink:href="#markC" transform="rotate(60,500,500)" />
    <use xlink:href="#markC" transform="rotate(90,500,500)" />
    <use xlink:href="#markC" transform="rotate(120,500,500)" />
    <use xlink:href="#markC" transform="rotate(150,500,500)" />
    <use xlink:href="#markC" transform="rotate(180,500,500)" />
    <use xlink:href="#markC" transform="rotate(210,500,500)" />
    <use xlink:href="#markC" transform="rotate(240,500,500)" />
    <use xlink:href="#markC" transform="rotate(270,500,500)" />
    <use xlink:href="#markC" transform="rotate(300,500,500)" />
    <use xlink:href="#markC" transform="rotate(330,500,500)" />
    </g>
    <g id="gridringD">
    <use xlink:href="#markD" transform="rotate(0,500,500)" />
    <use xlink:href="#markD" transform="rotate(30,500,500)" />
    <use xlink:href="#markD" transform="rotate(60,500,500)" />
    <use xlink:href="#markD" transform="rotate(90,500,500)" />
    <use xlink:href="#markD" transform="rotate(120,500,500)" />
    <use xlink:href="#markD" transform="rotate(150,500,500)" />
    <use xlink:href="#markD" transform="rotate(180,500,500)" />
    <use xlink:href="#markD" transform="rotate(210,500,500)" />
    <use xlink:href="#markD" transform="rotate(240,500,500)" />
    <use xlink:href="#markD" transform="rotate(270,500,500)" />
    <use xlink:href="#markD" transform="rotate(300,500,500)" />
    <use xlink:href="#markD" transform="rotate(330,500,500)" />
    </g>
    <g id="gridin">
    <line x1="500" y1="0" x2="500" y2="25" style="stroke:black;stroke-width:1" />
    <line x1="500" y1="975" x2="500" y2="1000" style="stroke:black;stroke-width:1" />
    <line x1="0" y1="500" x2="25" y2="500" style="stroke:black;stroke-width:1" />
    <line x1="975" y1="500" x2="1000" y2="500" style="stroke:black;stroke-width:1" />
    <line x1="500" y1="100" x2="500" y2="300" style="stroke:black;stroke-width:1" />
    <use xlink:href="#gridringA" />
    <use xlink:href="#gridringB" transform="rotate(6,500,500)" />
    <use xlink:href="#gridringB" transform="rotate(12,500,500)" />
    <use xlink:href="#gridringB" transform="rotate(18,500,500)" />
    <use xlink:href="#gridringB" transform="rotate(24,500,500)" />
    </g>
    <g id="gridout">
    <line x1="500" y1="50" x2="500" y2="75" style="stroke:black;stroke-width:1" />
    <line x1="500" y1="975" x2="500" y2="1000" style="stroke:black;stroke-width:1" />
    <line x1="0" y1="500" x2="25" y2="500" style="stroke:black;stroke-width:1" />
    <line x1="975" y1="500" x2="1000" y2="500" style="stroke:black;stroke-width:1" />
    <line x1="500" y1="100" x2="500" y2="300" style="stroke:black;stroke-width:1" />
    <use xlink:href="#gridringC" />
    <use xlink:href="#gridringD" transform="rotate(6,500,500)" />
    <use xlink:href="#gridringD" transform="rotate(12,500,500)" />
    <use xlink:href="#gridringD" transform="rotate(18,500,500)" />
    <use xlink:href="#gridringD" transform="rotate(24,500,500)" />
    </g>
    </defs>
    <g>
    <!--<circle cx ="500" cy ="500" r ="450" style="stroke:none;stroke-width:1;fill:black" />
    <circle cx ="500" cy ="500" r ="360" style="stroke:none;stroke-width:1;fill:white" />-->
    <use xlink:href="#gridin" />

    <xsl:choose>
      <xsl:when test="/syn:page[@js='yes']">
        <g id="rSeconds" transform="rotate({$secondsToday * 360 div $seconds1},500,500)">
          <g transform="translate(100,100) scale(0.8)">
            <use xlink:href="#gridin" id="seconds" />
          </g>
        </g>
        <g id="rMinutes" transform="rotate({$secondsToday * 360 div $seconds2},500,500)">
          <g transform="translate(100,100) scale(0.8)">
            <use xlink:href="#gridout" id="minutes" />
          </g>
        </g>
        <g id="rHours" transform="rotate({$secondsToday * 360 div $seconds3},500,500)">
          <use xlink:href="#gridout" id="hours" />
        </g>
        <syn:clock-options sSeconds="{$seconds1}" sMinutes="{$seconds2}" sHours="{$seconds3}" sDays="{$secondsPerDay}" reftime="{$seconds}" />
      </xsl:when>
      <xsl:otherwise>
        <g transform="rotate({$secondsToday * 360 div $seconds1},500,500) translate(100,100) scale(0.8)">
          <use xlink:href="#gridin" id="seconds">
            <animateTransform attributeName="transform" type="rotate" from="0 500 500" to="360 500 500" dur="{$seconds1}s" repeatDur="indefinite"/>
          </use>
        </g>
        <g transform="rotate({$secondsToday * 360 div $seconds2},500,500) translate(100,100) scale(0.8)">
          <use xlink:href="#gridout" id="minutes">
            <animateTransform attributeName="transform" type="rotate" from="0 500 500" to="360 500 500" dur="{$seconds2}s" repeatDur="indefinite"/>
          </use>
        </g>
        <g transform="rotate({$secondsToday * 360 div $seconds3},500,500)">
          <use xlink:href="#gridout" id="hours">
            <animateTransform attributeName="transform" type="rotate" from="0 500 500" to="360 500 500" dur="{$seconds3}s" repeatDur="indefinite"/>
          </use>
        </g>
      </xsl:otherwise>
    </xsl:choose>
    </g>
    </svg>
    </defs>
    <use xlink:href="#face" />
  </xsl:template>

  <xsl:template match="syn:clock[@render='analog']">
    <xsl:call-template name="analog-clock">
      <xsl:with-param name="seconds">
        <xsl:value-of select="date:seconds()" />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="syn:page">
    <svg version="1.1" viewBox="0 0 100 100">
      <xsl:apply-templates select="*" />
    </svg>
  </xsl:template>
</xsl:stylesheet>
