#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface ReprocessingViewController : GLKViewController
@property (strong, nonatomic) EAGLContext *context;
@property (nonatomic) CGSize viewSize;
@end
