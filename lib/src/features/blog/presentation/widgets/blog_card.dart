import 'package:blog_app/src/core/utils/calc_reading_time.dart';
import 'package:blog_app/src/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/blog/presentation/pages/blog_view_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 4),
      child: GestureDetector(
        onTap: () => Navigator.push(context, BlogViewPage.route(blog)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: blog.topics
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: Chip(
                                label: Text(e),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text("${calculatingReadingTime(blog.content)} min"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
