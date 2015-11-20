package inspirational.designs;

import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.themes.GradientTheme;
import inspirational.designs.DataHandler;
import inspirational.designs.UIBinder;

/**
 * ...
 * @author Shaheed Abdol
 */

class Main {

	public static var uiBinder: UIBinder;

	public static function main() {
		Toolkit.theme = new GradientTheme();
		Toolkit.init();
		
		Toolkit.openFullscreen(function(root:Root) {
			uiBinder = new UIBinder();
			root.addChild(uiBinder.controller.view);
		});
	}

}
