
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvmapp/presentation/resources/assets_manager.dart';
import 'package:mvvmapp/presentation/resources/string_manager.dart';
import 'package:mvvmapp/presentation/resources/value_manager.dart';
import '../resources/color_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();

  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() =>
      [
        SliderObject(
            AppStrings.onBoardingSubtitle1, AppStrings.onBoardingSubtitle1,
            ImageAssets.onBoardingLogo1),
        SliderObject(
            AppStrings.onBoardingSubtitle2, AppStrings.onBoardingSubtitle2,
            ImageAssets.onBoardingLogo2),
        SliderObject(
            AppStrings.onBoardingSubtitle3, AppStrings.onBoardingSubtitle3,
            ImageAssets.onBoardingLogo3),
        SliderObject(
            AppStrings.onBoardingSubtitle4, AppStrings.onBoardingSubtitle4,
            ImageAssets.onBoardingLogo4)
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _list.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(_list[index]);
          }),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,),
                )),

            //add Layout for indicator and arrows
            _getBottomSheetWidget()

          ],
        ),
      ),
    );
  }


  Widget _getBottomSheetWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // left arrow
        Padding(padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.leftArrowIc),
            ),
            onTap: () {
              // go to previous slide
              _pageController.animateToPage(_getPreviousIndex(), duration:const Duration(milliseconds: DurationConstant.d300), curve: Curves.bounceInOut);

            },
          ),),

        //circles indicator
        Row(
          children: [
            for(int i = 0; i < _list.length; i++)
              Padding(padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i),)
          ],
        ),
        // right arrow

        Padding(padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightArrowIc),
            ),
            onTap: () {
              // go to next slide
              _pageController.animateToPage(_getNextIndex(), duration:const Duration(milliseconds: DurationConstant.d300), curve: Curves.bounceInOut);
            },
          ),),


      ],
    );
  }

  int _getPreviousIndex(){
    int previouseIndex = _currentIndex --; // -1
    if(previouseIndex == -1){
      _currentIndex = _list.length - 1; // infinite loop to go to the lenght of slider list
    }
    return _currentIndex;
  }

  int _getNextIndex(){
    int nextIndex = _currentIndex ++; // -1
    if(nextIndex >= _list.length){
      _currentIndex = 0; // infinite loop to go to the lenght of slider list
    }
    return _currentIndex;
  }
  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc); // select slider
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

}
class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,),
        ),
        const SizedBox(height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.Image)
      ],
    );
  }
}


class SliderObject{
  late String title;
  late String subTitle;
  late String Image;

  SliderObject(this.title,this.subTitle, this.Image);
}
