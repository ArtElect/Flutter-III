import 'package:flutter/material.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:getwidget/getwidget.dart';

import 'package:client/services/profile.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/role_model.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/utils/color_checker.dart';

class BigProfilePage extends StatefulWidget {
  const BigProfilePage({Key? key}) : super(key: key);

  @override
  State<BigProfilePage> createState() => _BigProfilePageState();
}

class _BigProfilePageState extends State<BigProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final ProfileService _profileService = ProfileService();
  final List<String> textFieldsValue = [];

  Widget _buildRightPills({required List<RoleModel> roles}) {
    if (roles.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'No rights have been assign to you',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    List<Widget> childs = [];
    for (var i = 0; i < roles.length; i++) {
      childs.add(
        GFButton(
          text: roles[i].name,
          color: ColorChecker.getColorByLength(length: roles[i].rights.length),
          shape: GFButtonShape.pills,
          onPressed: () {},
        ),
      );
    }
    return Wrap(children: [...childs]);
  }

  Widget _buildProfileForm({required UserModel user}) {
    return SizedBox(
      width: 800,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: user.firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.grey500),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.grey500,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a first name';
                }
                textFieldsValue.add(value);
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: user.lastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.grey500),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.grey500,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a last name';
                }
                textFieldsValue.add(value);
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: user.pseudo,
              decoration: InputDecoration(
                labelText: 'Pseudo',
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.grey500),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.grey500,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a last name';
                }
                textFieldsValue.add(value);
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: user.image,
              decoration: InputDecoration(
                labelText: 'Image',
                hintText: 'http://image.com',
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.image),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.grey500),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.grey500,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image url';
                }
                textFieldsValue.add(value);
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            GFButton(
              text: "Update",
              color: GFColors.PRIMARY,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var res = await _profileService.updateCurrentAccount(
                      textFieldsValue[0],
                      textFieldsValue[1],
                      textFieldsValue[2],
                      textFieldsValue[3]
                  );
                  if (res) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Update successful')),
                    );
                  } else if (!res) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Update failed')),
                    );
                  } else {
                    const CircularProgressIndicator();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarContainer({required UserModel user}) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user.image != ""
              ? GFAvatar(
                  backgroundImage: NetworkImage(user.image!),
                  radius: 100.0,
                )
              : GFAvatar(
                  child: Center(
                    child: Text(user.firstName[0],
                        style: const TextStyle(fontSize: 60)),
                  ),
                  radius: 100.0,
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID: ${user.id}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: MyColors.subtext,
                      fontSize: 14,
                    ),
                  ),
                  _buildRightPills(roles: _profileService.roles)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      "Profile",
      style: TextStyle(
        color: MyColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _buildContent({required UserModel user}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        height: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildAvatarContainer(user: user),
                    _buildProfileForm(user: user),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(50),
                child: Center(
                  child: Image.asset('assets/images/profile.png'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 3),
          FutureBuilder<UserModel>(
            future: _profileService.getUserInformation(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return _buildContent(user: snapshot.data!);
              } else {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
