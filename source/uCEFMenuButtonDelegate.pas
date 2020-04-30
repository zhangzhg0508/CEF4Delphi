// ************************************************************************
// ***************************** CEF4Delphi *******************************
// ************************************************************************
//
// CEF4Delphi is based on DCEF3 which uses CEF to embed a chromium-based
// browser in Delphi applications.
//
// The original license of DCEF3 still applies to CEF4Delphi.
//
// For more information about CEF4Delphi visit :
//         https://www.briskbard.com/index.php?lang=en&pageid=cef
//
//        Copyright � 2020 Salvador Diaz Fau. All rights reserved.
//
// ************************************************************************
// ************ vvvv Original license and comments below vvvv *************
// ************************************************************************
(*
 *                       Delphi Chromium Embedded 3
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 * Web site   : http://www.progdigy.com
 * Repository : http://code.google.com/p/delphichromiumembedded/
 * Group      : http://groups.google.com/group/delphichromiumembedded
 *
 * Embarcadero Technologies, Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 *)

unit uCEFMenuButtonDelegate;

{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
{$ENDIF}

{$IFNDEF CPUX64}{$ALIGN ON}{$ENDIF}
{$MINENUMSIZE 4}

{$I cef.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, System.SysUtils,
  {$ELSE}
  Classes, SysUtils,
  {$ENDIF}
  uCEFBaseRefCounted, uCEFInterfaces, uCEFTypes, uCEFButtonDelegate;

type
  TCefMenuButtonDelegateRef = class(TCefButtonDelegateRef, ICefMenuButtonDelegate)
    protected
      procedure OnMenuButtonPressed(const menu_button: ICefMenuButton; const screen_point: TCefPoint; const button_pressed_lock: ICefMenuButtonPressedLock);

    public
      class function UnWrap(data: Pointer): ICefMenuButtonDelegate;
  end;

implementation

uses
  uCEFLibFunctions, uCEFMiscFunctions;

procedure TCefMenuButtonDelegateRef.OnMenuButtonPressed(const menu_button         : ICefMenuButton;
                                                        const screen_point        : TCefPoint;
                                                        const button_pressed_lock : ICefMenuButtonPressedLock);
begin
  PCefMenuButtonDelegate(FData)^.on_menu_button_pressed(PCefMenuButtonDelegate(FData),
                                                        CefGetData(menu_button),
                                                        @screen_point,
                                                        CefGetData(button_pressed_lock));
end;

class function TCefMenuButtonDelegateRef.UnWrap(data: Pointer): ICefMenuButtonDelegate;
begin
  if (data <> nil) then
    Result := Create(data) as ICefMenuButtonDelegate
   else
    Result := nil;
end;

end.
