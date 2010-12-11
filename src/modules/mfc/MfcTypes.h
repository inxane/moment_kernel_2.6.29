/* mfc/MfcTypes.h
 *
 * Copyright (c) 2008 Samsung Electronics
 *
 * Samsung S3C MFC driver
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
#ifndef __SAMSUNG_SYSLSI_APDEV_MFC_TYPE_H__
#define __SAMSUNG_SYSLSI_APDEV_MFC_TYPE_H__

#ifdef __cplusplus
extern "C" {
#endif


#ifdef _WIN32_WCE
#include <windows.h>

#else

#include <linux/types.h>

typedef enum {FALSE, TRUE} BOOL;

#endif


#ifdef __cplusplus
}
#endif

#endif /* __SAMSUNG_SYSLSI_APDEV_MFC_TYPE_H__ */