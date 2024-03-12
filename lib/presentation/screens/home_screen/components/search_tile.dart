import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../resources/utils/color_constants.dart';
import '../../../../resources/utils/string_constants.dart';

class SearchTile extends StatelessWidget {
  final Function(String val) onSearch;
  final Function() onVoiceInput;
  final TextEditingController searchController;

  const SearchTile(
      {super.key,
      required this.onSearch,
      required this.onVoiceInput,
      required this.searchController});

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
                          color: ClrConst.greyClr.withOpacity(0.5),
                          blurRadius: 4.sp,
                          offset: const Offset(4, 2))
                    ],
                    color: ClrConst.blackClr.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12.sp)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (val) {
                          if (val != '') {
                            onSearch(val);
                            searchController.clear();
                          } else {
                            onSearch(StrConst.emptyString);
                          }
                        },
                        cursorColor: ClrConst.whiteClr,
                        style: TextStyle(color: ClrConst.whiteClr),
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
                          onVoiceInput();
                        },
                        child: Icon(
                          CupertinoIcons.mic,
                          color: ClrConst.whiteClr,
                        ),
                      ),
                    )
                  ],
                ))),
      ],
    );
  }
}
