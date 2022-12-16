import 'dart:math';

import 'package:flutter/material.dart';

var loginRoute = '/login';
var signupRoute = '/signup';
var homePageRoute = '/start';
var cartRoute = '/cart';
var checkoutRoute = '/checkout';
var accountRoute = '/account';
var favouriteRoute = '/favourites';
var processOrderRoute = '/processOrder';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPadding = 20.0;
const kElectronPink25 = Color(0xFFFAEFED);

const kElectronPink50 = Color(0xFFFEEAE6);
const kElectronPink100 = Color(0xFFFEDBD0);
const kElectronPink300 = Color(0xFFFBB8AC);
const kElectronPink400 = Color(0xFFEAA4A4);

const kElectronBrown900 = Color(0xFF442B2D);

const kElectronErrorRed = Color(0xFFC5032B);

const kElectronSurfaceWhite = Color(0xFFFFFBFA);
const kElectronBackgroundWhite = Colors.white;

const kElectronPurple = Color(0xFF5D1049);

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
