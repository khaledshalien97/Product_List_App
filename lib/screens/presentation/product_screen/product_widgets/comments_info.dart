import 'package:flutter/material.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/data/models/product_model.dart';
import 'package:product_list_app/data/models/review_model.dart';

class CommentsInfo extends StatefulWidget {
  final ProductModel product;
  const CommentsInfo({super.key, required this.product});

  @override
  State<CommentsInfo> createState() => _CommentsInfoState();
}

class _CommentsInfoState extends State<CommentsInfo> {
  late List<ReviewModel> _reviews;

  double get _avgRating => _reviews.isEmpty
      ? widget.product.rating
      : _reviews.map((r) => r.rating).reduce((a, b) => a + b) / _reviews.length;

  String _fmtDate(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  Widget _stars(double rating, {double size = 16}) {
    final full = rating.floor();
    final half = (rating - full) >= 0.25 && (rating - full) < 0.75;
    final widgets = <Widget>[];
    for (var i = 0; i < full && widgets.length < 5; i++) {
      widgets.add(Icon(Icons.star_rounded, size: size, color: Colors.amber));
    }
    if (half && widgets.length < 5) {
      widgets.add(
        Icon(Icons.star_half_rounded, size: size, color: Colors.amber),
      );
    }
    while (widgets.length < 5) {
      widgets.add(
        Icon(Icons.star_border_rounded, size: size, color: Colors.amber),
      );
    }
    return Row(children: widgets);
  }

  @override
  void initState() {
    super.initState();
    _reviews = List<ReviewModel>.from(widget.product.reviews);
  }

  void _showAddReviewSheet() {
    final txtCtrl = TextEditingController();
    int tempRating = 4;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (ctx, setInner) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Write a review",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),

                Row(
                  children: List.generate(5, (i) {
                    final idx = i + 1;
                    final active = idx <= tempRating;
                    return IconButton(
                      onPressed: () => setInner(() => tempRating = idx),
                      icon: Icon(
                        active ? Icons.star_rounded : Icons.star_border_rounded,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),

                TextField(
                  controller: txtCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Share your experience...",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.deepCyan,
                    ),
                    onPressed: () {
                      final text = txtCtrl.text.trim();
                      if (text.isEmpty) {
                        Navigator.pop(ctx);
                        return;
                      }
                      setState(() {
                        _reviews.add(
                          ReviewModel(
                            rating: tempRating,
                            comment: text,
                            date: DateTime.now(),
                            reviewerName: "You",
                            reviewerEmail: "",
                          ),
                        );
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Review added")),
                      );
                    },
                    child: const Text("Post"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Customer Reviews",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            _stars(_avgRating, size: 18),
            const SizedBox(width: 6),
            Text(
              "(${_reviews.length})",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: _reviews.isEmpty
              ? Center(
                  child: Text(
                    "No reviews yet.",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                )
              : ListView.separated(
                  itemCount: _reviews.length,
                  separatorBuilder: (_, __) => const Divider(height: 16),
                  itemBuilder: (_, i) {
                    final r = _reviews[i];
                    final initials = r.reviewerName.isNotEmpty
                        ? r.reviewerName
                              .trim()
                              .split(' ')
                              .map((e) => e[0])
                              .take(2)
                              .join()
                        : 'U';
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 16, child: Text(initials)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      r.reviewerName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _fmtDate(r.date),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              _stars(r.rating.toDouble()),
                              const SizedBox(height: 6),
                              Text(r.comment),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),

        const SizedBox(height: 12),

        OutlinedButton.icon(
          onPressed: _showAddReviewSheet,
          icon: const Icon(Icons.rate_review_outlined),
          label: const Text("Add a review"),
        ),

        const SizedBox(height: 60),
      ],
    );
  }
}
