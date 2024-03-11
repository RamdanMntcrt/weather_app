import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTile extends StatelessWidget {
  final Function(String val) onSearch;

  const SearchTile({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4.sp,
                          offset: const Offset(4, 2))
                    ],
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12.sp)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (val) {
                          onSearch(val);
                        },
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            border: InputBorder.none,
                            hintText: 'Search City',
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 14)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.sp),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: const Icon(
                          CupertinoIcons.mic,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))),
      ],
    );
  }
}
