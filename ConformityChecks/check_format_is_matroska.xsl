<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mc="https://mediaarea.net/mediaarea" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" extension-element-prefixes="xsi">
    <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
    <xsl:template match="mc:MediaArea">
        <MediaConch>
            <policyChecks>
                <xsl:attribute name="version">
                    <xsl:text>0.1</xsl:text>
                </xsl:attribute>
                <xsl:for-each select="mc:media">
                    <media>
                        <xsl:attribute name="ref"><xsl:value-of select="./@ref"/></xsl:attribute>
                        <policy>
                            <xsl:call-template name="are_equal">
                                <xsl:with-param name="title">Is Matroska"</xsl:with-param>
                                <xsl:with-param name="key" select="mc:MediaInfo/mc:track[@type='General'][1]/mc:Format"/>
                                <xsl:with-param name="value">Matroska</xsl:with-param>
                                <xsl:with-param name="tracktype">General</xsl:with-param>
                                <xsl:with-param name="occurrence">1</xsl:with-param>
                                <xsl:with-param name="field">Format</xsl:with-param>
                            </xsl:call-template>
                        </policy>
                        <policy>
                            <xsl:call-template name="are_equal">
                                <xsl:with-param name="title">Is FFV1</xsl:with-param>
                                <xsl:with-param name="key" select="mc:MediaInfo/mc:track[@type='Video'][1]/mc:Format"/>
                                <xsl:with-param name="value">FFV1</xsl:with-param>
                                <xsl:with-param name="tracktype">Video</xsl:with-param>
                                <xsl:with-param name="occurrence">1</xsl:with-param>
                                <xsl:with-param name="field">Format</xsl:with-param>
                            </xsl:call-template>
                        </policy>
                        <policy>
                            <xsl:call-template name="are_equal">
                                <xsl:with-param name="key" select="mc:MediaInfo/mc:track[@type='Video'][1]/mc:Format_Version"/>
                                <xsl:with-param name="value">Version 3.1</xsl:with-param>
                                <xsl:with-param name="tracktype">Video</xsl:with-param>
                                <xsl:with-param name="occurrence">1</xsl:with-param>
                                <xsl:with-param name="field">Format_Version</xsl:with-param>
                            </xsl:call-template>
                        </policy>
                        <policy>
                            <xsl:call-template name="is_greater_than">
                                <xsl:with-param name="key" select="mc:MediaInfo/mc:track[@type='General'][1]/mc:FileSize"/>
                                <xsl:with-param name="value">0</xsl:with-param>
                                <xsl:with-param name="tracktype">General</xsl:with-param>
                                <xsl:with-param name="occurrence">1</xsl:with-param>
                                <xsl:with-param name="field">FileSize</xsl:with-param>
                            </xsl:call-template>
                        </policy>
                        <policy>
                            <xsl:call-template name="exists">
                                <xsl:with-param name="key" select="mc:MediaInfo/mc:track[@type='Video'][1]/mc:Format"/>
                                <xsl:with-param name="tracktype">Video</xsl:with-param>
                                <xsl:with-param name="occurrence">1</xsl:with-param>
                                <xsl:with-param name="field">Format</xsl:with-param>
                            </xsl:call-template>
                        </policy>
                        <policy>
                            <xsl:call-template name="does_not_exist">
                                <xsl:with-param name="key" select="mc:MediaInfo/mc:track[@type='Video'][1]/mc:Formatzzzzz"/>
                                <xsl:with-param name="tracktype">Video</xsl:with-param>
                                <xsl:with-param name="occurrence">1</xsl:with-param>
                                <xsl:with-param name="field">Formatzzzzz</xsl:with-param>
                            </xsl:call-template>
                        </policy>
                    </media>
                </xsl:for-each>
            </policyChecks>
        </MediaConch>
    </xsl:template>
    
    <xsl:template name="are_equal">
        <xsl:param name="key"/>
        <xsl:param name="value"/>
        <xsl:attribute name="expected"><xsl:value-of select="$value"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="$key = $value">
                <xsl:attribute name="outcome">pass</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">unexpected value</xsl:attribute>
                <value>
                    <xsl:value-of select="$key"/>
                </value>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="is_greater_than">
        <xsl:param name="key"/>
        <xsl:param name="value"/>
        <xsl:attribute name="expected"><xsl:value-of select="$value"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="$key &gt; $value">
                <xsl:attribute name="outcome">pass</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">unexpected value</xsl:attribute>
                <value>
                    <xsl:value-of select="$key"/>
                </value>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="is_less_than">
        <xsl:param name="key"/>
        <xsl:param name="value"/>
        <xsl:attribute name="expected"><xsl:value-of select="$value"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="$key &lt; $value">
                <xsl:attribute name="outcome">pass</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">unexpected value</xsl:attribute>
                <value>
                    <xsl:value-of select="$key"/>
                </value>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="is_greater_or_equal_than">
        <xsl:param name="key"/>
        <xsl:param name="value"/>
        <xsl:attribute name="expected"><xsl:value-of select="$value"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="$key &gt;= $value">
                <xsl:attribute name="outcome">pass</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">unexpected value</xsl:attribute>
                <value>
                    <xsl:value-of select="$key"/>
                </value>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="is_less_or_equal_than">
        <xsl:param name="key"/>
        <xsl:param name="value"/>
        <xsl:attribute name="expected"><xsl:value-of select="$value"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="$key &lt;= $value">
                <xsl:attribute name="outcome">pass</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">unexpected value</xsl:attribute>
                <value>
                    <xsl:value-of select="$key"/>
                </value>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="is_not_equal">
        <xsl:param name="key"/>
        <xsl:param name="value"/>
        <xsl:attribute name="expected"><xsl:value-of select="$value"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="$key != $value">
                <xsl:attribute name="outcome">pass</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">unexpected value</xsl:attribute>
                <value>
                    <xsl:value-of select="$key"/>
                </value>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="exists">
        <xsl:param name="key"/>
        <xsl:if test="count($key) > 0">exists</xsl:if>
    </xsl:template>

    <xsl:template name="does_not_exist">
        <xsl:param name="key"/>
        <xsl:if test="count($key) = 0">does not exist</xsl:if>
    </xsl:template>


</xsl:stylesheet>