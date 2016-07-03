#!/bin/sh
set -e

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

case "${TARGETED_DEVICE_FAMILY}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

realpath() {
  DIRECTORY="$(cd "${1%/*}" && pwd)"
  FILENAME="${1##*/}"
  echo "$DIRECTORY/$FILENAME"
}

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\""
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE=$(realpath "$RESOURCE_PATH")
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH"
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/Appirater/Appirater.bundle"
  install_resource "FormatterKit/Localizations/ar.lproj"
  install_resource "FormatterKit/Localizations/ca.lproj"
  install_resource "FormatterKit/Localizations/cs.lproj"
  install_resource "FormatterKit/Localizations/da.lproj"
  install_resource "FormatterKit/Localizations/de.lproj"
  install_resource "FormatterKit/Localizations/el.lproj"
  install_resource "FormatterKit/Localizations/en.lproj"
  install_resource "FormatterKit/Localizations/es.lproj"
  install_resource "FormatterKit/Localizations/fr.lproj"
  install_resource "FormatterKit/Localizations/he.lproj"
  install_resource "FormatterKit/Localizations/hu.lproj"
  install_resource "FormatterKit/Localizations/id.lproj"
  install_resource "FormatterKit/Localizations/it.lproj"
  install_resource "FormatterKit/Localizations/ja.lproj"
  install_resource "FormatterKit/Localizations/ko.lproj"
  install_resource "FormatterKit/Localizations/ms.lproj"
  install_resource "FormatterKit/Localizations/nb.lproj"
  install_resource "FormatterKit/Localizations/nl.lproj"
  install_resource "FormatterKit/Localizations/nn.lproj"
  install_resource "FormatterKit/Localizations/pl.lproj"
  install_resource "FormatterKit/Localizations/pt.lproj"
  install_resource "FormatterKit/Localizations/pt_BR.lproj"
  install_resource "FormatterKit/Localizations/ro.lproj"
  install_resource "FormatterKit/Localizations/ru.lproj"
  install_resource "FormatterKit/Localizations/sv.lproj"
  install_resource "FormatterKit/Localizations/th.lproj"
  install_resource "FormatterKit/Localizations/tr.lproj"
  install_resource "FormatterKit/Localizations/uk.lproj"
  install_resource "FormatterKit/Localizations/vi.lproj"
  install_resource "FormatterKit/Localizations/zh-Hans.lproj"
  install_resource "FormatterKit/Localizations/zh-Hant.lproj"
  install_resource "GPUImage/framework/Resources/lookup.png"
  install_resource "GPUImage/framework/Resources/lookup_amatorka.png"
  install_resource "GPUImage/framework/Resources/lookup_miss_etikate.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_1.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_2.png"
  install_resource "IQKeyboardManager/IQKeyBoardManager/Resources/IQKeyboardManager.bundle"
  install_resource "OcticonsIOS/OcticonsIOS/octicons.ttf"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/UMSocialSDKResourcesNew.bundle"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/TencentOpenApi_IOS_Bundle.bundle"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_Extra_Frameworks/SinaSSO/WeiboSDK.bundle"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSCommentDetailController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSCommentInputController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSCommentInputControlleriPad.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMShareEditViewController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMShareEditViewControlleriPad.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSLoginViewController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSnsAccountViewController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSShareListController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/en.lproj"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/zh-Hans.lproj"
  install_resource "WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.js.txt"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/Appirater/Appirater.bundle"
  install_resource "FormatterKit/Localizations/ar.lproj"
  install_resource "FormatterKit/Localizations/ca.lproj"
  install_resource "FormatterKit/Localizations/cs.lproj"
  install_resource "FormatterKit/Localizations/da.lproj"
  install_resource "FormatterKit/Localizations/de.lproj"
  install_resource "FormatterKit/Localizations/el.lproj"
  install_resource "FormatterKit/Localizations/en.lproj"
  install_resource "FormatterKit/Localizations/es.lproj"
  install_resource "FormatterKit/Localizations/fr.lproj"
  install_resource "FormatterKit/Localizations/he.lproj"
  install_resource "FormatterKit/Localizations/hu.lproj"
  install_resource "FormatterKit/Localizations/id.lproj"
  install_resource "FormatterKit/Localizations/it.lproj"
  install_resource "FormatterKit/Localizations/ja.lproj"
  install_resource "FormatterKit/Localizations/ko.lproj"
  install_resource "FormatterKit/Localizations/ms.lproj"
  install_resource "FormatterKit/Localizations/nb.lproj"
  install_resource "FormatterKit/Localizations/nl.lproj"
  install_resource "FormatterKit/Localizations/nn.lproj"
  install_resource "FormatterKit/Localizations/pl.lproj"
  install_resource "FormatterKit/Localizations/pt.lproj"
  install_resource "FormatterKit/Localizations/pt_BR.lproj"
  install_resource "FormatterKit/Localizations/ro.lproj"
  install_resource "FormatterKit/Localizations/ru.lproj"
  install_resource "FormatterKit/Localizations/sv.lproj"
  install_resource "FormatterKit/Localizations/th.lproj"
  install_resource "FormatterKit/Localizations/tr.lproj"
  install_resource "FormatterKit/Localizations/uk.lproj"
  install_resource "FormatterKit/Localizations/vi.lproj"
  install_resource "FormatterKit/Localizations/zh-Hans.lproj"
  install_resource "FormatterKit/Localizations/zh-Hant.lproj"
  install_resource "GPUImage/framework/Resources/lookup.png"
  install_resource "GPUImage/framework/Resources/lookup_amatorka.png"
  install_resource "GPUImage/framework/Resources/lookup_miss_etikate.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_1.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_2.png"
  install_resource "IQKeyboardManager/IQKeyBoardManager/Resources/IQKeyboardManager.bundle"
  install_resource "OcticonsIOS/OcticonsIOS/octicons.ttf"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/UMSocialSDKResourcesNew.bundle"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/TencentOpenApi_IOS_Bundle.bundle"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_Extra_Frameworks/SinaSSO/WeiboSDK.bundle"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSCommentDetailController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSCommentInputController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSCommentInputControlleriPad.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMShareEditViewController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMShareEditViewControlleriPad.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSLoginViewController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSnsAccountViewController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/SocialSDKXib/UMSShareListController.xib"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/en.lproj"
  install_resource "UMengSocial/Umeng_SDK_Social_iOS_ARM64_4.4/UMSocial_Sdk_4.4/zh-Hans.lproj"
  install_resource "WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.js.txt"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "`realpath $PODS_ROOT`*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
