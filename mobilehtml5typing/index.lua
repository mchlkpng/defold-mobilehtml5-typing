if sys.get_sys_info().system_name ~= "HTML5" then return false end
if not jstodef then
	error("mobilehtml5-typing require 'jstodef' to work!\nDownload the lastest release here: https://github.com/AGulev/jstodef/releases")
	return false
end

local check = [[var answer = document.getElementById("result");
window.checkIfMobile = () => {
	let a = false;
	if (navigator.userAgent.match(/Android/i)
	|| navigator.userAgent.match(/webOS/i)
	|| navigator.userAgent.match(/iPhone/i)
	|| navigator.userAgent.match(/iPad/i)
	|| navigator.userAgent.match(/iPod/i)
	|| navigator.userAgent.match(/BlackBerry/i)
	|| navigator.userAgent.match(/Windows Phone/i)) {
		a = true;
	}
	else if (navigator.userAgent.match(/Macintosh/i)
		&& navigator.maxTouchPoints && navigator.maxTouchPoints > 2) {
			a = true;
		}
		else {
			a = false;
		}
	return a;
}
window.checkIfMobile();
]]

--[[local onmobile = html5.run([[window.mobileAndTabletCheck1234 = function() {
	let check = false;
	(function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
		return check;
	}; window.mobileAndTabletCheck1234()]]

local onmobile = html5.run(check)


--if onmobile ~= "true" then return false end


local mht = {}

local run = [[
let textBoxOpened = false
let listener = (evt) => {
	const textbox = document.getElementById("defold-mobilehtml5-text-input");
	let targetEl = evt.target;     
	do {
		if(targetEl == textbox) {
			return;
		}
		targetEl = targetEl.parentNode;
	} while (targetEl);
	closeTextBox()
}

let listener2 = (evt) => {
	if (evt.key === "Enter" || evt.keyCode === 13) {
		closeTextBox()
		document.removeEventListener("mousedown", listener)
		setTimeout(() => {
			document.removeEventListener("keydown", listener2)
		}, 50);
	}
}

function openTextBox(currentText) {
	if (document.getElementById("defold-mobilehtml5-text-input")) {return}
	let canvas = document.getElementById("canvas");
	let width = canvas.getAttribute("width")
	let e = document.createElement("input");
	e.setAttribute("id", "defold-mobilehtml5-text-input")
	e.setAttribute("type", "text")
	e.setAttribute("style", `width: 80%; height: 10%; top: 20%; position: absolute; left: 0`)
	e.value = currentText || ""

	let b = document.createElement("button");
	b.innerHTML = "Done";
	b.setAttribute("id", "defold-mobilehtml5-text-input-button")
	b.setAttribute("style", "width: 17%; height: 10%; top: 20%; position: absolute; right: 0")
	b.setAttribute("onclick", "closeTextBox()")

	let parent = document.getElementById("canvas-container")
	parent.appendChild(e)
	parent.appendChild(b)

	setTimeout(() => {
		e.focus()
		e.select()
	}, 100)

	document.addEventListener("mousedown", listener)
	document.addEventListener("keydown", listener2)
}

function closeTextBox() {
	textBoxOpened = false
	if (document.getElementById("defold-mobilehtml5-text-input")) {
		let value = document.getElementById("defold-mobilehtml5-text-input").value;
		JsToDef.send("mobilehtml5-typing_text", {text: value})
		document.getElementById("defold-mobilehtml5-text-input").remove()
		document.getElementById("defold-mobilehtml5-text-input-button").remove()
	}
	document.removeEventListener("keydown", listener2)
	setTimeout(() => {
		document.removeEventListener("mousedown", listener)
	}, 50);

}


]]

function mht.openTextBox(startingText)
	if startingText and type(startingText) ~= "string" then
		error("type of 'startingText' must be string, got type "..type(startingText)..".")
		return
	end
	local st = startingText or ""
	html5.run(run.."openTextBox(`"..st.."`)")
end

local function killListener(listener)
	timer.delay(0.05, false, function() 
		if listener then
			jstodef.remove_listener(listener)
		end
	end)
end

function mht.onText(self, callback)
	if type(self) ~= "userdata" then
		error("type of 'self' must be... ya know... 'self'. I have no idea why you even set it to anything else. Got type "..type(self)..".")
		return
	end
	if type(callback) ~= "function" then
		error("type of 'callback' must be function, got type "..type(callback)..".")
		return
	end

	local listener = function(self, message_id, message)
		callback(self, message.text)
	end
	jstodef.add_listener(listener)

	return listener
end

function mht.removeListener(listener)
	if type(listener) ~= "function" then
		error("type of 'listener' must be function, got type "..type(listener)..".")
		return
	end
	killListener(listener)
end

return mht