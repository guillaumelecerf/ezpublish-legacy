{let approval_content=$collaboration_item.content
     objectversion=fetch( content, version,
                          hash( object_id, $approval_content.content_object_id,
                                version_id, $approval_content.content_object_version ) )}
{set-block scope=root variable=subject}{'[%sitename] Approval of "%objectname" awaits your attention'
                                        |i18n( "design/standard/collaboration/approval",,
                                               hash( '%sitename', ezini( "SiteSettings", "SiteURL" ),
                                                     '%objectname', $objectversion.version_name ) )}{/set-block}
{'This email is to inform you that "%objectname" awaits your attention at %sitename.
The publishing process has been halted and it is up to you to decide if it should continue or stop.
The approval can viewed by using the URL below.'
 |i18n( 'design/standard/collaboration/approval',,
        hash( '%sitename', ezini( "SiteSettings", "SiteURL" ),
              '%objectname', $objectversion.version_name ) )}
http://{ezini( "SiteSettings", "SiteURL" )}{concat( "collaboration/item/full/", $collaboration_item.id )|ezurl( no )}

{"If you do not wish to continue receiving these notifications,
change your settings at:"|i18n( 'design/standard/notification' )}
http://{ezini( "SiteSettings", "SiteURL" )}{concat( "notification/settings/" )|ezurl( no )}

-- 
{"%sitename notification system"
 |i18n( 'design/standard/notification',,
        hash( '%sitename', ezini( "SiteSettings", "SiteURL" ) ) )}
{/let}