import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/components/textbox/textbox.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      onTap: () => {},
      leading: const ProjectLogo(
        url:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png",
      ),
      title: const ProjectInformation(
        title: "Project A",
        description:
            "The goal of this project is to develop flutter application",
        timeline: "01.01.2022 - 01.02.2022",
        role: "développeur",
      ),
      trailing: const ProjectOverview(),
    );
  }
}

class ProjectLogo extends StatelessWidget {
  final String url;
  const ProjectLogo({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Image.network(
            url,
            width: 48,
            height: 48,
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
    );
  }
}

class ProjectInformation extends StatelessWidget {
  final String title;
  final String description;
  final String timeline;
  final String role;
  const ProjectInformation({
    Key? key,
    required this.title,
    required this.description,
    required this.timeline,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: MyColors.purple,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(title, style: const TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 5),
        Text(description, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 5),
        // Text(timeline, style: const TextStyle(color: MyColors.subtext)),
        LinearPercentIndicator(
          width: 250,
          lineHeight: 20,
          percent: 0.1,
          progressColor: Colors.green,
          animation: true,
          animationDuration: 500,
          center: const Text("7 days left"),
        ),
        const SizedBox(height: 5),
        Text(
          "Participe en tant que $role",
          style: const TextStyle(color: MyColors.subtext),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class ProjectOverview extends StatelessWidget {
  const ProjectOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: double.infinity,
      color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          TextBox(name: "6", label: "Finished task"),
          TextBox(name: "2", label: "Remaning task"),
          TextBox(name: "10", label: "Number of members"),
          TextBox(name: "10%", label: "Project completion"),
        ],
      ),
    );
  }
}
