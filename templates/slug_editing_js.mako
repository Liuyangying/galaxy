<%namespace file="/display_common.mako" import="get_controller_name" />

<%def name="slug_editing_js(item)">
    <% controller_name = get_controller_name( item ) %>
    <script type="text/javascript">
    
        // slug_editing_js.mako
        
        var save_url = "${h.url_for( controller=controller_name, action='set_slug_async', id=trans.security.encode_id( item.id ) )}";

        config.addInitialization(function() {
            console.log("slug_editing_js.mako init");

            //
            // Set up slug-editing functionality.
            //
            var on_start = function( text_elt ) {
                // Replace URL with URL text.
                $('#item-url').hide();
                $('#item-url-text').show();

                // Allow only lowercase alphanumeric and '-' characters in slug.
                text_elt.keyup(function(){
                    text_elt.val( $(this).val().replace(/\s+/g,'-').replace(/[^a-zA-Z0-9\-]/g,'').toLowerCase() )
                });
            };

            var on_finish = function( text_elt ) {
                // Replace URL text with URL.
                $('#item-url-text').hide();
                $('#item-url').show();

                // Set URL to new value.
                var new_url = $('#item-url-text').text();
                var item_url_obj = $('#item-url');
                item_url_obj.attr( "href", new_url );
                item_url_obj.text( new_url );
            };

            window.bundleEntries.async_save_text("edit-identifier", "item-identifier", save_url, "new_slug", null, false, 0, on_start, on_finish);

        });
    </script>
</%def>
