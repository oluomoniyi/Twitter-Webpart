<xsl:stylesheet xmlns:x="http://www.w3.org/2001/XMLSchema"
               version="1.0" exclude-result-prefixes="xsl ddwrt msxsl rssaggwrt" 
               xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime"
               xmlns:rssaggwrt="http://schemas.microsoft.com/WebParts/v3/rssagg/runtime"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
               xmlns:rssFeed="urn:schemas-microsoft-com:sharepoint:RSSAggregatorWebPart"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:rss1="http://purl.org/rss/1.0/" xmlns:atom="http://www.w3.org/2005/Atom"
               xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
               xmlns:atom2="http://purl.org/atom/ns#">

    <xsl:param name="rss_FeedLimit">20</xsl:param>
    <xsl:param name="rss_ExpandFeed">false</xsl:param>
    <xsl:param name="rss_LCID">1033</xsl:param>
    <xsl:param name="rss_WebPartID">RSS_Viewer_WebPart</xsl:param>
    <xsl:param name="rss_alignValue">left</xsl:param>
    <xsl:param name="rss_IsDesignMode">True</xsl:param>

        <xsl:template match="rss">
			<div class="rssfeedMain">
				<xsl:call-template name="RSSMainTemplate"/>
				<!--a class="twitter-timeline" data-dnt="true" href="https://twitter.com/search?q=From%3Aajgbenefits%20OR%20From%3Aajgwealth%20OR%20From%3ASHILLING_thinks" data-widget-id="562248584104804352" target="_blank">More Tweets about From:@ajgbenefits, @ajgwealth OR @SHILLING_thinks</a-->
				<img src="../PublishingImages/Twitter_bottom.jpg"/>
			</div>
			<script type="text/javascript">
			alert("data");
				$(".rssfeedMain a[href^='http://']").attr("target","_blank");
			</script>
        </xsl:template>

        <xsl:template name="RSSMainTemplate" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:variable name="Rows" select="channel/item"/>
            <xsl:variable name="RowCount" select="count($Rows)"/>
            <div class="slm-layout-main" >            
            <!--div class="groupheader item medium">
                        <a href="{ddwrt:EnsureAllowedProtocol(string(channel/link))}">
                            <xsl:value-of select="channel/title"/>
                        </a>
            </div Olu change header-->     
			
				<a class="twitter-timeline" data-dnt="true" href="https://twitter.com/search?q=From%3Aajgbenefits%20OR%20From%3Aajgwealth%20OR%20From%3ASHILLING_thinks" data-widget-id="562248584104804352" target="_blank">
					<!--h1>
					<img src="https://g.twimg.com/Twitter_logo_blue.png" height="15" align="baseline"/Our Tweets>
					
					</h1-->
					<img src="../PublishingImages/Twitter_head.jpg"/>
				</a>
			
			<ul class="noSpace">
				<xsl:call-template name="RSSMainTemplate.body">
					<xsl:with-param name="Rows" select="$Rows"/>
					<xsl:with-param name="RowCount" select="count($Rows)"/>
				</xsl:call-template>
			</ul>
            </div>
        </xsl:template>

        <xsl:template name="RSSMainTemplate.body" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="Rows"/>
            <xsl:param name="RowCount"/>
            <xsl:for-each select="$Rows">
                <xsl:variable name="CurPosition" select="position()" />
                <xsl:variable name="RssFeedLink" select="$rss_WebPartID" />
                <xsl:variable name="CurrentElement" select="concat($RssFeedLink,$CurPosition)" />
                <xsl:if test="($CurPosition &lt;= $rss_FeedLimit)">
                    <li class="item link-item" style="margin-left:17px!important">
                            <!--  Olu remove content a href="{concat(&quot;javascript:ToggleItemDescription('&quot;,$CurrentElement,&quot;')&quot;)}" >
                                <xsl:value-of select="title"/>
                            </a-->
                            <xsl:if test="$rss_ExpandFeed = true()">
                                <xsl:call-template name="RSSMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:block;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                            <xsl:if test="$rss_ExpandFeed = false()">
                                <xsl:call-template name="RSSMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:none;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                    </li>                            
                </xsl:if>
            </xsl:for-each>
        </xsl:template>

	<xsl:template name="RSSMainTemplate.description" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="DescriptionStyle"/>
            <xsl:param name="CurrentElement"/>
	    <div id="{$CurrentElement}" class="description" align="{$rss_alignValue}" style="{$DescriptionStyle} text-align:{$rss_alignValue};">
                <xsl:choose>
                    <!-- some RSS2.0 contain pubDate tag, some others dc:date -->
                    <xsl:when test="string-length(pubDate) &gt; 0">
                        <xsl:variable name="pubDateLength" select="string-length(pubDate) - 3" />
		        <xsl:value-of select="ddwrt:FormatDate(substring(pubDate,0,$pubDateLength),number($rss_LCID),3)"/>
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:value-of select="ddwrt:FormatDate(string(dc:date),number($rss_LCID),3)"/>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:if test="string-length(description) &gt; 0">
                    <xsl:variable name="SafeHtml">
                        <xsl:call-template name="GetSafeHtml">
                            <xsl:with-param name="Html" select="description"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/>
                </xsl:if>
		    <div class="description" style="text-align: right;">
		        <a href="{ddwrt:EnsureAllowedProtocol(string(link))}" target="_blank">More...</a>
	        </div>
        </div>
        </xsl:template>

        <xsl:template name="GetSafeHtml">
            <xsl:param name="Html"/>
            <xsl:choose>
                <xsl:when test="$rss_IsDesignMode = 'True'">
                     <xsl:value-of select="$Html"/>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:value-of select="rssaggwrt:MakeSafe($Html)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>
		
	
</xsl:stylesheet>