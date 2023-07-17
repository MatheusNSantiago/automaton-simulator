import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';


import '../../components/menu_container.dart';

class HamburgerMenu extends StatelessWidget {
  final VoidCallback onTapOutside;
  const HamburgerMenu({
    required this.onTapOutside,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      child: TapRegion(
        onTapOutside: (_) => onTapOutside(),
        child: MenuContainer(
          width: 280,
          height: 300,
          type: MenuContainerType.column,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          children: [
            HamburgerMenuItem(
              label: "Novo coiso",
              onPressed: () {},
              icon: addNewFile,
            ),
            const Divider(thickness: 0.1),
            HamburgerMenuItem(
              label: "Entrar",
              onPressed: () {},
              icon: Ri.login_box_line,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class HamburgerMenuItem extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onPressed;
  final double size;

  const HamburgerMenuItem({
    required this.label,
    required this.onPressed,
    required this.icon,
    this.size = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.centerLeft,
          foregroundColor: Colors.white,
        ),
        label: Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        // icon: Iconify(icon, color: Colors.white, size: size),
        icon: Iconify(icon, color: Colors.white, size: size),
        onPressed: onPressed,
      ),
    );
  }
}

const addNewFile =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="width: 24px; height: 24px;" class="uk-margin-small-right uk-svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M17 5.5H8c-.437 0-.83.186-1.103.483h-1.72A3.001 3.001 0 0 1 8 4h9c1.3 0 2.407.827 2.823 1.983h-1.72A1.496 1.496 0 0 0 17 5.5ZM7 8.475h11a1.5 1.5 0 0 1 1.5 1.5v8a1.5 1.5 0 0 1-1.5 1.5h-8v1.5h8a3 3 0 0 0 3-3v-8a3 3 0 0 0-3-3H7a3 3 0 0 0-3 3v2.95h1.5v-2.95a1.5 1.5 0 0 1 1.5-1.5Zm2.019 9.549c0 2.165-1.835 3.976-4.01 3.976C2.81 22 1 20.205 1 18.024c0-2.182 1.81-3.976 4.01-3.976 2.19 0 4.009 1.794 4.009 3.976Zm-4.541 2.083c0 .304.25.502.531.502.282 0 .532-.198.532-.502v-1.59h1.485c.274 0 .498-.23.498-.501a.503.503 0 0 0-.498-.494H5.541v-1.59c0-.304-.25-.501-.532-.501-.282 0-.531.197-.531.502v1.589H2.992a.51.51 0 0 0-.506.494c0 .271.232.502.506.502h1.486v1.589Z" fill="currentcolor"></path></svg>';
