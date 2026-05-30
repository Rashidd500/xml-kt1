<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="utf-8"/>

    <!-- города -->
    <xsl:key name="cityKey"
             match="item"
             use="@city"/>

    <!-- компании -->
    <xsl:key name="orgKey"
             match="item"
             use="concat(@city,'|',@org)"/>

    <xsl:template match="/">

        <html>
            <head>
                <title>Города</title>
            </head>

            <body>

                <h1>Города и компании</h1>

                <ul>

                    <xsl:for-each select="
                        orgs/item[
                            generate-id() =
                            generate-id(key('cityKey', @city)[1])
                        ]">

                        <li>
                            <h3>
                                <xsl:value-of select="@city"/>
                            </h3>
                            <p>
                                Всего товаров:
                                <xsl:value-of select="count(key('cityKey', @city))"/>
                            </p>

                            <xsl:for-each select="
                                key('cityKey', @city)
                                [
                                    generate-id() =
                                    generate-id(
                                        key(
                                            'orgKey',
                                            concat(@city,'|',@org)
                                        )[1]
                                    )
                                ]">

                                <ul>
                                    <li>

                                        <h4>
                                            <xsl:value-of select="@org"/>
                                        </h4>
                                        <p>
                                            Всего товаров:
                                            <xsl:value-of select="
                                                count(
                                                    key(
                                                        'orgKey',
                                                        concat(@city,'|',@org)
                                                    )
                                                )"/>
                                        </p>

                                        <ul>

                                            <xsl:for-each select="
                                                key(
                                                    'orgKey',
                                                    concat(@city,'|',@org)
                                                )">

                                                <li>
                                                    <xsl:value-of select="@title"/>
                                                </li>
                                            </xsl:for-each>
                                        </ul>

                                    </li>
                                </ul>

                            </xsl:for-each>
                        </li>

                    </xsl:for-each>
                </ul>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>