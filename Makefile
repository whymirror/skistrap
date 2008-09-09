SRC = skia/animator/SkTime.cpp skia/corecg/Sk64.cpp skia/corecg/SkBuffer.cpp skia/corecg/SkChunkAlloc.cpp skia/corecg/SkCordic.cpp skia/corecg/SkDebug.cpp skia/corecg/SkDebug_stdio.cpp skia/corecg/SkFloat.cpp skia/corecg/SkInterpolator.cpp skia/corecg/SkMath.cpp skia/corecg/SkMatrix.cpp skia/corecg/SkMemory_stdlib.cpp skia/corecg/SkPoint.cpp skia/corecg/SkRect.cpp skia/corecg/SkRegion.cpp skia/effects/Sk1DPathEffect.cpp skia/effects/Sk2DPathEffect.cpp skia/effects/SkAvoidXfermode.cpp skia/effects/SkBlurDrawLooper.cpp skia/effects/SkBlurMask.cpp skia/effects/SkBlurMaskFilter.cpp skia/effects/SkCamera.cpp skia/effects/SkColorFilters.cpp skia/effects/SkColorMatrix.cpp skia/effects/SkColorMatrixFilter.cpp skia/effects/SkCornerPathEffect.cpp skia/effects/SkCullPoints.cpp skia/effects/SkDashPathEffect.cpp skia/effects/SkDiscretePathEffect.cpp skia/effects/SkEmbossMask.cpp skia/effects/SkEmbossMaskFilter.cpp skia/effects/SkGradientShader.cpp skia/effects/SkKernel33MaskFilter.cpp skia/effects/SkLayerRasterizer.cpp skia/effects/SkPaintFlagsDrawFilter.cpp skia/effects/SkPixelXorXfermode.cpp skia/effects/SkShaderExtras.cpp skia/effects/SkTransparentShader.cpp skia/effects/SkUnitMappers.cpp skia/images/bmpdecoderhelper.cpp skia/images/SkImageDecoder.cpp skia/images/SkImageDecoder_libbmp.cpp skia/images/SkImageDecoder_libgif.cpp skia/images/SkImageDecoder_libico.cpp skia/images/SkImageDecoder_libjpeg.cpp skia/images/SkImageDecoder_libpng.cpp skia/images/SkImageDecoder_wbmp.cpp skia/images/SkImageRef.cpp skia/images/SkMovie.cpp skia/images/SkMovie_gif.cpp skia/images/SkScaledBitmapSampler.cpp skia/images/SkStream.cpp skia/picture/SkPictureFlat.cpp skia/picture/SkPicturePlayback.cpp skia/picture/SkPictureRecord.cpp skia/ports/SkFontHost_none.cpp skia/ports/SkGlobals_global.cpp skia/ports/SkImageDecoder_Factory.cpp skia/ports/SkOSFile_stdio.cpp skia/sgl/SkAlphaRuns.cpp skia/sgl/SkBitmap.cpp skia/sgl/SkBitmapProcShader.cpp skia/sgl/SkBitmapProcState.cpp skia/sgl/SkBitmapProcState_matrixProcs.cpp skia/sgl/SkBitmapSampler.cpp skia/sgl/SkBitmapShader.cpp skia/sgl/SkBlitRow_D16.cpp skia/sgl/SkBlitRow_D4444.cpp skia/sgl/SkBlitter.cpp skia/sgl/SkBlitter_4444.cpp skia/sgl/SkBlitter_A1.cpp skia/sgl/SkBlitter_A8.cpp skia/sgl/SkBlitter_ARGB32.cpp skia/sgl/SkBlitter_RGB16.cpp skia/sgl/SkBlitter_Sprite.cpp skia/sgl/SkCanvas.cpp skia/sgl/SkColor.cpp skia/sgl/SkColorFilter.cpp skia/sgl/SkColorTable.cpp skia/sgl/SkDeque.cpp skia/sgl/SkDevice.cpp skia/sgl/SkDither.cpp skia/sgl/SkDraw.cpp skia/sgl/SkEdge.cpp skia/sgl/SkFilterProc.cpp skia/sgl/SkFlattenable.cpp skia/sgl/SkGeometry.cpp skia/sgl/SkGlobals.cpp skia/sgl/SkGlyphCache.cpp skia/sgl/SkGraphics.cpp skia/sgl/SkMask.cpp skia/sgl/SkMaskFilter.cpp skia/sgl/SkPackBits.cpp skia/sgl/SkPaint.cpp skia/sgl/SkPath.cpp skia/sgl/SkPathEffect.cpp skia/sgl/SkPathMeasure.cpp skia/sgl/SkPicture.cpp skia/sgl/SkPixelRef.cpp skia/sgl/SkProcSpriteBlitter.cpp skia/sgl/SkPtrRecorder.cpp skia/sgl/SkRasterizer.cpp skia/sgl/SkRefCnt.cpp skia/sgl/SkRegion_path.cpp skia/sgl/SkScalerContext.cpp skia/sgl/SkScan.cpp skia/sgl/SkScan_Antihair.cpp skia/sgl/SkScan_AntiPath.cpp skia/sgl/SkScan_Hairline.cpp skia/sgl/SkScan_Path.cpp skia/sgl/SkShader.cpp skia/sgl/SkSpriteBlitter_ARGB32.cpp skia/sgl/SkSpriteBlitter_RGB16.cpp skia/sgl/SkString.cpp skia/sgl/SkStroke.cpp skia/sgl/SkStrokerPriv.cpp skia/sgl/SkTSearch.cpp skia/sgl/SkTypeface_fake.cpp skia/sgl/SkUnPreMultiply.cpp skia/sgl/SkUtils.cpp skia/sgl/SkWriter32.cpp skia/sgl/SkXfermode.cpp skia/ports/SkThread_pthread.cpp
OBJ = ${SRC:.cpp=.o}
CC = g++
CCFLAGS = -Iskia/include -Iskia/include/corecg -Iskia/corecg -Iskia/sgl -Iskia/picture -DSK_BUILD_FOR_UNIXx

all: options skia

fetch:
	@echo Fetching Skia...
	@svn co http://src.chromium.org/svn/trunk/src/skia
	@echo Checked out to 'skia'

options:
	@echo skia build options:
	@echo "CCFLAGS  = ${CCFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.cpp.o:
	@echo CC $<
	@${CC} -c ${CCFLAGS} $< -o $@

.c.o:
	@echo CC $<
	@${CC} -c ${CCFLAGS} $< -o $@

clean:
	@echo cleaning
	@rm -f skia ${OBJ}

skia: libskia.so

libskia.so: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS} -fPIC -shared

test: xlib-test

xlib-test: xlib-test.o
	@echo CC -o $@
	@${CC} -o $@ xlib-test.o ${OBJ} ${LDFLAGS} -lpng -ljpeg -lgif -lpthread -lX11
