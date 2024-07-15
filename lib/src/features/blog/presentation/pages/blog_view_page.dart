import 'package:blog_app/src/core/theme/app_pallete.dart';
import 'package:blog_app/src/core/utils/calc_reading_time.dart';
import 'package:blog_app/src/core/utils/format_date.dart';
import 'package:blog_app/src/features/blog/domain/entities/blog_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  final BlogEntity blog;
  static route(BlogEntity blog) => MaterialPageRoute(
        builder: (context) => BlogViewPage(blog: blog),
      );
  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  "By ${blog.name}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  "${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculatingReadingTime(blog.content)} min",
                  style: const TextStyle(color: AppPallete.greyColor, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(imageUrl: blog.imageUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
