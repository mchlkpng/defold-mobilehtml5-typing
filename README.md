# MobileHtml5-type
This is a lua module that allows text input through the `<input>`  tag on the HTML page, only in mobile browsers. It works through [jstodef](https://github.com/AGulev/jstodef), which is required.

Feel free to make any changes to the html that you would like.


## Installation

 - Add a version URL of **jstodef** to dependencies from [their releases](https://github.com/AGulev/jstodef/releases). Preferably, use this release as it was used to write this code:
 
		 https://github.com/AGulev/jstodef/archive/refs/tags/2.0.0.zip
 - Get a version link from [Releases](https://github.com/mchlkpng/defold-mobilehtml5-typing/releases/) or add this link to dependencies:
	
		https://github.com/mchlkpng/defold-mobilehtml5-typing/main.zip

 - Require the lua module.

    ```lua
    local mht = require "mobilehtml5-typing.index"
    ```
  #### Note: The module will only require if it's being run on a mobile browser, so make sure to check if the module had even returned.
```lua
if mht then
	
end
```
## API
### mht.openTextBox(startingText)
Creates an ``<input>`` and ``<button>`` node that will take and submit the text.

 
 - `startingText` - The text that will be inside the input box when opened (can be nil).


Example:
``` lua
function on_input(self, action_id, action)
    if action_id == hash("touch") and mht then
        mht.openTextBox(self.text)
    end
end
```
<hr>

### mht.onText(self, callback(self, text))
Detects when the text is submitted.

 - `self` - 'self'
 - `callback` - Function called after text is submitted. <br>
&nbsp;&nbsp;&nbsp;&nbsp;self - 'self' <br>
&nbsp;&nbsp;&nbsp;&nbsp;text - The text from the input box.

#### returns:

 - `listener` - Handle for the listener.

Example:
```lua
function init(self)
	if mht then
        self.listener = mht.onText(self, function(self, text)
            print("text: ", text)
            label.set_text("#label", text)
        end)
    end
end
```
<hr>

### mht.removeListener(listener)
Removes an existing listener.

- `listener` - Handle function returned by `mht.onText()`

Example:
```lua
function on_message(self, message_id, message, sender)
	if message_id == hash("removelistener") and mht then
	    mht.removeListener(self.listener)
    end
end
```

        
