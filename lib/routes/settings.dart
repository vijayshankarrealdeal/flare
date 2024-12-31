import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radiant/modules/settings_logic.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: "Account",
        middle: Text("Settings"),
      ),
      child: SafeArea(
        child: Consumer<SettingsLogic>(builder: (context, settingsLogic, _) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CupertinoFormSection(
                      decoration: BoxDecoration(
                        color: settingsLogic.dark
                            ? CupertinoColors.darkBackgroundGray
                            : CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      header: const Text("User Settings"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 45,
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: const Text(
                                          "Add/Change Profile Picture"),
                                      onPressed: () {},
                                    ),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: const Text(
                                        "Remove Profile Picture",
                                        style: TextStyle(
                                            color:
                                                CupertinoColors.destructiveRed),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        CupertinoTextFormFieldRow(
                          controller: TextEditingController(),
                          prefix: const Text("Name"),
                          placeholder: "Change Name",
                        ),
                        CupertinoTextFormFieldRow(
                          controller: TextEditingController(),
                          prefix: const Text("UserName"),
                          placeholder: "Change UserName",
                        ),
                      ],
                    ),
                    CupertinoFormSection(
                        decoration: BoxDecoration(
                          color: settingsLogic.dark
                              ? CupertinoColors.darkBackgroundGray
                              : CupertinoColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        header: const Text("App Settings"),
                        children: [
                          CupertinoFormRow(
                            prefix: Row(
                              children: [
                                Icon(settingsLogic.dark
                                    ? CupertinoIcons.light_max
                                    : CupertinoIcons.light_min),
                                const SizedBox(width: 10),
                                Text(settingsLogic.dark
                                    ? "Switch Light Mode "
                                    : "Switch Dark Mode"),
                              ],
                            ),
                            child: CupertinoSwitch(
                              value: settingsLogic.dark,
                              onChanged: (value) =>
                                  settingsLogic.changeMode(value),
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Row(
                              children: [
                                Icon(
                                  CupertinoIcons.lock,
                                ),
                                SizedBox(width: 10),
                                Text("Data & Privacy"),
                              ],
                            ),
                            child: CupertinoButton(
                                onPressed: () {},
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child:
                                    const Icon(CupertinoIcons.chevron_forward)),
                          ),
                          CupertinoFormRow(
                            prefix: const Row(
                              children: [
                                Icon(
                                  CupertinoIcons.person_badge_minus,
                                ),
                                SizedBox(width: 10),
                                Text("Blocked Users"),
                              ],
                            ),
                            child: CupertinoButton(
                                onPressed: () {},
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child:
                                    const Icon(CupertinoIcons.chevron_forward)),
                          ),
                          CupertinoFormRow(
                            prefix: const Row(
                              children: [
                                Icon(CupertinoIcons.globe,
                                    color: CupertinoColors.activeGreen),
                                SizedBox(width: 10),
                                Text("Languages"),
                              ],
                            ),
                            child: CupertinoButton(
                                onPressed: () {},
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child:
                                    const Icon(CupertinoIcons.chevron_forward)),
                          ),
                        ]),
                    CupertinoFormSection(
                        decoration: BoxDecoration(
                          color: settingsLogic.dark
                              ? CupertinoColors.darkBackgroundGray
                              : CupertinoColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        header: const Text("Help"),
                        children: [
                          CupertinoFormRow(
                            prefix: const Row(
                              children: [
                                Icon(
                                  CupertinoIcons.exclamationmark_triangle,
                                ),
                                SizedBox(width: 10),
                                Text("Report"),
                              ],
                            ),
                            child: CupertinoButton(
                                onPressed: () {},
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child:
                                    const Icon(CupertinoIcons.chevron_forward)),
                          ),
                          CupertinoFormRow(
                            prefix: const Row(
                              children: [
                                Icon(CupertinoIcons.delete,
                                    color: CupertinoColors.destructiveRed),
                                SizedBox(width: 10),
                                Text("Delete Account"),
                              ],
                            ),
                            child: CupertinoButton(
                                onPressed: () {},
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: const Text("Proceed")),
                          )
                        ]),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
