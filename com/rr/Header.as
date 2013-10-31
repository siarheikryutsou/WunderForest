﻿package com.rr {		import com.rr.events.NavigationEvent;	import flash.display.DisplayObject;	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	import com.flashgangsta.managers.ButtonManager;	import com.rr.utils.BitmapLoader;	import fl.text.TLFTextField;	import com.rr.utils.TextConverter;	import flash.events.EventDispatcher;	import flash.events.FullScreenEvent;	import flash.geom.Rectangle;		public class Header extends Sprite {				private var userNameLabel:TLFTextField;		private var ratingBtn:MovieClip;		private var nutsLabel:TLFTextField;		private var goldLabel:TLFTextField;		/// Кнопка перехода в банк		private var bankBtn:MovieClip;		private var userAvatar:MovieClip;		private var nickBorder:MovieClip;		/// Панель навигации		private var navigation:Navigation;		/// Диспатчер		private var dispatcher:EventDispatcher = Helper.getDispatcher();				/**		 * Конструктор		 */				public function Header() {			addEventListener( Event.ADDED_TO_STAGE, init );		}				/**		 * Инициализация		 * @param	event		 */				private function init( event:Event ):void {			removeEventListener( Event.ADDED_TO_STAGE, init );						var profile:Profile = Helper.getProfile();						navigation = getChildByName( "navigation_mc" ) as Navigation;			userNameLabel = getChildByName( "userName_txt" ) as TLFTextField;			ratingBtn = getChildByName( "rating_mc" ) as MovieClip;			nutsLabel = getChildByName( "nuts_txt" ) as TLFTextField;			goldLabel = getChildByName( "gold_txt" ) as TLFTextField;			bankBtn = getChildByName( "bankBtn_mc" ) as MovieClip;			userAvatar = getChildByName( "userAvatar_mc" ) as MovieClip;			nickBorder = getChildByName( "nickBorder_mc" ) as MovieClip;						dispatcher.addEventListener( Event.RESIZE, resize );						ButtonManager.addButton( ratingBtn, null, showRating );			//TODO: Новая иерархия			ButtonManager.addButton( bankBtn, null, bankBtnClicked );						userNameLabel.text = profile.firstName + " " + ( profile.nickName !== null ? ( profile.nickName + " " ) : "" ) + profile.lastName;						ratingBtn.label_mc.label_txt.text = profile.rating.toString();						if( userNameLabel.x + userNameLabel.textWidth < nickBorder.x ) {				nickBorder.visible = false;			}						new BitmapLoader( profile.photoMediumPath, userAvatar, BitmapLoader.SCALE_FILL, BitmapLoader.ALIGN_CENTER_TOP  );						setNuts( profile.nuts );			setGold ( profile.gold );		}				/**		 * Обработка нажатия кнопки перехода в банк		 * @param	target		 */				private function bankBtnClicked( target:MovieClip ):void {			dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.BANK_CALLED ) );		}				/**		 * Обновляет отображение количества орехов		 * @param	value		 */				private function setNuts( value:Number ):void {			nutsLabel.text = TextConverter.getNumber( value );		}				/**		 * Обновляет отображение количества золота		 * @param	value		 */				private function setGold( value:Number ):void {			goldLabel.text = TextConverter.getNumber( value );		}				/**		 * Выводит окно рейтинга		 * @param	target		 */				private function showRating( target:MovieClip ):void {					}				/**		 * Обновляет позиционирование после смены размера флешки		 */				private function resize( event:Event = null ):void {			var rect:Rectangle = Helper.getScreenController().getScreenRect();			x = rect.x;			y = rect.y;			navigation.x = rect.width - navigation.width - Main.MARGIN;		}			}	}